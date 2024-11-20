/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package sample.shopping;

import java.sql.Timestamp;

public class HistoryUser{
    private Timestamp date;
    private String username;
    private String product;
    private int quantity;
    private double price;
    private double total;

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getProduct() {
        return product;
    }

    public void setProduct(String product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public HistoryUser(Timestamp date, String username, String product, int quantity, double price, double total) {
        this.date = date;
        this.username = username;
        this.product = product;
        this.quantity = quantity;
        this.price = price;
        this.total = total;
    }

    public HistoryUser() {
    }
    
    
}
