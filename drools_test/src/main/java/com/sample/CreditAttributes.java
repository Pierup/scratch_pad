package com.sample;

import java.util.HashMap;

public class CreditAttributes {
	public int fico;
	public String user_id;
	public int v_3111;
	public int v_3161;
	public int v_3204;
	public int v_3228;
	public int v_3362;
	public int v_3726;
	public int v_3748;
	
	enum CreditCategory {SUPER_PRIME, PRIME, SUB_PRIME, NONE};
	
	private CreditCategory category;
	private int limit=0;
	private int shadowLimit=0;
	private HashMap<String, String> message = new HashMap<String, String>(); 
	
	public CreditAttributes(Builder builder) {
		this.fico = builder.fico;
		this.user_id = builder.user_id;
		this.v_3111 = builder.v_3111;
		this.v_3161 = builder.v_3161;
		this.v_3204 = builder.v_3204;
		this.v_3228 = builder.v_3228;
		this.v_3362 = builder.v_3362;
		this.v_3748 = builder.v_3748;
		this.v_3726 = builder.v_3726;
	}

	public static Builder newBuilder(){
        return new Builder();
    }
	
	public void setCategory(CreditAttributes.CreditCategory category){
		this.category = category;
	}	
	public CreditCategory getCategory(){
		return this.category;
	}
	
	public void setLimit(int _limit){
		this.limit = _limit;		
	}
	public int getLimit(){
		return this.limit;
	}
	
	public void setShadowLimit(int _shadowlimit){
		this.shadowLimit = _shadowlimit;		
	}
	public int getShadowLimit(){
		return this.shadowLimit;
	}
	
	public void addMessage(String key, String Message){
		message.put(key, Message);
	}
	public HashMap<String, String> getMessage(){
		return this.message;
	}
	
	public static class Builder{
		// "3228", "3161", "3204", "3748", "3726" subprime
		//"3228", "3111", "3161", "3204", "3748" superprime
		//"3362", "3111", "3161", "3204", "3748" prime
		private int fico;
		private String user_id;
		private int v_3111;
		private int v_3161;
		private int v_3204;
		private int v_3228;
		private int v_3362;
		private int v_3726;
		private int v_3748;
		
		public Builder setFico(int _fico){
			this.fico = _fico;
			return this;
		}
		public int getFico(){
			return this.fico;
		}
		public Builder setUserId(String _user_id){
			this.user_id = _user_id;
			return this;
		}
		public Builder set3111(int _3111){
			this.v_3111 = _3111;
			return this;
		}
		public Builder set3161(int _3161){
			this.v_3161 = _3161;
			return this;
		}
		public Builder set3204(int _3204){
			this.v_3204 = _3204;
			return this;
		}
		public Builder set3228(int _3228){
			this.v_3228 = _3228;
			return this;
		}
		public Builder set3362(int _3362){
			this.v_3362 = _3362;
			return this;
		}
		public Builder set3726(int _3726){
			this.v_3726 = _3726;
			return this;
		}
		public Builder set3748(int _3748){
			this.v_3748 = _3748;
			return this;
		}
		
		public CreditAttributes build(){
			return new CreditAttributes(this);
		}
	}
}
