package com.sample;

import java.util.HashMap;

public class EquifaxInfo{
	//TODO: builder design pattern
	
	// "3228", "3161", "3204", "3748", "3726" subprime
	//"3228", "3111", "3161", "3204", "3748" superprime
	//"3362", "3111", "3161", "3204", "3748" prime
	private int fico;
	private String userId;
	private int v3111;
	private int v3161;
	private int v3204;
	private int v3228;
	private int v3362;
	private int v3726;
	private int v3748;
	
	//-----base line--------
	private int v3426;
	private int v3603;
	private int v3903;
	private int v3905;
	private int v3807;
	private int v3798;
	
	
	private int limit=0;
	private int shadowLimit=0;
	
	private HashMap<String, String> message = new HashMap<String, String>(); 
	
	private String rule;

	
	public enum Category {SUPER_PRIME, PRIME, SUB_PRIME, DEFAULT, NONE};
	
	private Category category = Category.NONE;
	
	public void setCategory(Category category){
		this.category = category;
	}
	public Category getCategory(){
		return this.category;
	}
	
	public EquifaxInfo(String userId){
		this.userId = userId;
	}
	
	public void  setFico(int _fico){
		this.fico = _fico;
	}
	public int getFico(){
		return this.fico;
	}
	
	public void setUserId(String _user_id){
		this.userId = _user_id;
	}
	public String getUserId(){
		return this.userId;
	}
	
	public void setV3111(int _3111){
		this.v3111 = _3111;
	}
	public int getV3111(){
		return this.v3111;
	}
	
	public void setV3161(int _3161){
		this.v3161 = _3161;
	}
	public int getV3161(){
		return this.v3161;
	}
	
	public void setV3204(int _3204){
		this.v3204 = _3204;
	}
	public int getV3204(){
		return this.v3204;
	}
	
	public void setV3228(int _3228){
		this.v3228 = _3228;
	}
	public int getV3228(){
		return this.v3228;
	}
	
	public void setV3362(int _3362){
		this.v3362 = _3362;
	}
	public int getV3362(){
		return this.v3362;
	}
	
	public void setV3726(int _3726){
		this.v3726 = _3726;
	}
	public int getV3726(){
		return this.v3726;
	}
	
	public void setV3748(int _3748){
		this.v3748 = _3748;
	}
	public int getV3748(){
		return this.v3748;
	}
	
	//------------------------------------------
	public void setV3426(int _3426){
		this.v3426 = _3426;
	}
	public int getV3426(){
		return this.v3426;
	}
	
	public void setV3603(int _3603){
		this.v3603 = _3603;
	}
	public int getV3603(){
		return this.v3603;
	}
	
	
	public void setV3903(int _3903){
		this.v3903 = _3903;
	}
	public int getV3903(){
		return this.v3903;
	}
	
	public void setV3905(int _3905){
		this.v3905 = _3905;
	}
	public int getV3905(){
		return this.v3905;
	}
	
	public void setV3807(int _3807){
		this.v3807 = _3807;
	}
	public int getV3807(){
		return this.v3807;
	}
	
	public void setV3798(int _3798){
		this.v3798 = _3798;
	}
	public int getV3798(){
		return this.v3798;
	}
	
	public void setLimit(int limit){
		this.limit = limit;
	}
	
	public void setShadowLimit(int shadowLimit){
		this.shadowLimit = shadowLimit;
	}
	
	public void setRule(String rule){
		this.rule = rule;
	}
	
	public void addMessage(String key, String Message){
		message.put(key, Message);
	}
	public HashMap<String, String> getMessage(){
		return this.message;
	}
	
	@Override
    public String toString(){
		StringBuilder sb = new StringBuilder();
		sb.append("{user_id:").append(this.userId)
			.append(",fico:").append(this.fico)
			.append(",category:").append(category).append(",limit:").append(limit)
			.append(",shadowLimit:").append(this.shadowLimit)
			.append(",message:").append(this.message)
			.append(",rule:").append(rule).append("}");
		return sb.toString();      
    }
}
