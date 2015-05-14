package com.sample;

public class Credit{
	public enum Category {SUPER_PRIME, PRIME, SUB_PRIME, DEFAULT, NONE};
	
	private Category category;
	private int limit=0;
	private int shadowLimit=0;

	public void setCategory(Category category){
		this.category = category;		
	}
	public Category getCategory(){
		return this.category;		
	}
	
	public void setLimit(int limit){
		this.limit = limit;
	}
	
	public void setShadowLimit(int shadowLimit){
		this.shadowLimit = shadowLimit;
	}
	
	@Override
    public String toString(){
		StringBuilder sb = new StringBuilder();
		sb.append("{category:").append(category).append(",limit:").append(limit).append("}");
		return sb.toString();      
    } 
	
}
