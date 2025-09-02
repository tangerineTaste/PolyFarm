package com;

public class Item {
    private int id;
    private String name;
    private int price;
    private String image; // 이미지 URL 필드 추가

    public Item(int id, String name, int price, String image) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.image = image; // 이미지 URL 초기화
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
}



