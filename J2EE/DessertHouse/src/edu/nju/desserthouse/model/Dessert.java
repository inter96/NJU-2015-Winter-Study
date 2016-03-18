package edu.nju.desserthouse.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="dessert")
public class Dessert implements Serializable{
	@Id
	private int did;
	private String name;
	private String image;
	
	public Dessert(){}
	public Dessert(int did, String name, String image) {
		super();
		this.did = did;
		this.name = name;
		this.image = image;
	}
	public int getDid() {
		return did;
	}
	public void setDid(int did) {
		this.did = did;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	
}
