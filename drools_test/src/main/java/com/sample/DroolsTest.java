package com.sample;

import org.kie.api.KieServices;
import org.kie.api.runtime.KieContainer;
import org.kie.api.runtime.KieSession;

/**
 * This is a sample class to launch a rule.
 */
public class DroolsTest {

    public static final void main(String[] args) {
        try {
            // load up the knowledge base
	        KieServices ks = KieServices.Factory.get();
    	    KieContainer kContainer = ks.getKieClasspathContainer();
        	KieSession kSession = kContainer.newKieSession("ksession-rules");
          
            EquifaxInfo creditInfo = new EquifaxInfo("UR0000000001");
            creditInfo.setFico(725);
            creditInfo.setV3111(39);
            creditInfo.setV3228(0);
            creditInfo.setV3161(800);
            creditInfo.setV3204(1200);
            creditInfo.setV3748(1);
            creditInfo.setV3726(0);
            
            creditInfo.setV3903(0);
            creditInfo.setV3905(0);
            creditInfo.setV3603(0);
            creditInfo.setV3426(0);
            creditInfo.setV3798(0);
            
            
            //---------------------------------------------------------
            
            EquifaxInfo creditInfo2 = new EquifaxInfo("UR0000000001");
            creditInfo2.setFico(725);
            creditInfo2.setV3111(39);
            creditInfo2.setV3228(2);
            creditInfo2.setV3161(580);
            creditInfo2.setV3204(8000);
            
            creditInfo2.setV3748(1);
            creditInfo2.setV3726(0);
            
            creditInfo2.setV3903(0);
            creditInfo2.setV3905(0);
            creditInfo2.setV3603(0);
            creditInfo2.setV3426(0);
            creditInfo2.setV3798(450);
            creditInfo2.setV3807(1);
            
            
            
 //fico>=720, v3228==0, v3111>=36, v3161*1.0/v3204 <= 0.5, v3204/v3748>5000
//$info: EquifaxInfo(fico>=620, v3228==0, v3204/v3748>1000, (v3204-v3161)/v3748>=500, v3726==0)
            //kSession.insert(creditInfo);
            kSession.insert(creditInfo2);
            /*
            
            CreditAttributes.Builder creditBuilder = CreditAttributes.newBuilder();
            creditBuilder.setUserId("UR0000000012").setFico(725).set3111(39).set3161(800)
            	.set3204(1200).set3228(0).set3362(0).set3726(0).set3748(1);
            
//            CreditAttributes credit = new CreditAttributes(creditBuilder);
            
            kSession.insert(creditBuilder);
            */
           
            kSession.fireAllRules();
            System.out.println("--------" + creditInfo2.toString());
        } catch (Throwable t) {
            t.printStackTrace();
        }
    }

    public static class Message {

        public static final int HELLO = 0;
        public static final int GOODBYE = 1;

        private String message;

        private int status;

        public String getMessage() {
            return this.message;
        }

        public void setMessage(String message) {
            this.message = message;
        }

        public int getStatus() {
            return this.status;
        }

        public void setStatus(int status) {
            this.status = status;
        }

    }

}
