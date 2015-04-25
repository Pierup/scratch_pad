package com.JavaTest;
import javax.servlet.Filter;

import net.sf.json.JSONObject;

import org.springframework.boot.*;
import org.springframework.boot.autoconfigure.*;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.commons.configuration.ConfigurationException;

import com.pier.model.SDKResult;
import com.pier.model.TransactionConfig;
import com.pier.sdk.MerchantSDKClient;

@Controller
@EnableAutoConfiguration
public class Application {
	
	@Bean
	public Filter SimpleCORSFilter() {
	    return new SimpleCORSFilter();
	}

    public static void main(String[] args) throws Exception {
    	try {
    		PropertiesConfiguration config = new PropertiesConfiguration("config.properties");
    		config.setProperty("pier.pay.server.host", "http://pierup.ddns.net:8686/");
    		config.save();
    	} catch (ConfigurationException e) {
			System.out.println(e);
		}
        SpringApplication.run(Application.class, args);
    }
    
    @RequestMapping(value="/test/{amount}/{auth_token}/{currency}/{order_id}",method=RequestMethod.GET)
	public @ResponseBody JSONObject test(
			@PathVariable(value="auth_token") String auth_token,
			@PathVariable(value="amount") Double amount,
			@PathVariable(value="currency") String currency,
			@PathVariable(value="order_id") String order_id)
	{	
		JSONObject jsonObject=new JSONObject();
		try {
			MerchantSDKClient client = MerchantSDKClient.newBuilder()
					.setMerchant_id("MC0000014895").build();
			
			TransactionConfig config = TransactionConfig.newBuilder()
					.setAmount(amount)
					.setApi_id("5b52051a-931a-11e4-aad2-0ea81fa3d43c")
					.setApi_secret_key("mk-test-5b52041f-931a-11e4-aad2-0ea81fa3d43c")
					.setAuth_token(auth_token)
					.setCurrency(currency)
					.setId_in_merchant(order_id)
					.setNotes("my dummy java SDK test merchant").build();

			SDKResult result = client.transaction(config);
			
			jsonObject.accumulate("code", result.getCode());
			jsonObject.accumulate("message", result.getMessage());
			jsonObject.accumulate("result", result.getResult()==null?"":result.getResult());
		} catch (Exception e) {
			jsonObject.accumulate("code", "500");
			jsonObject.accumulate("message", "Fail");
			jsonObject.accumulate("result", "");
		}
		return jsonObject;
	}
   
}