/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.shopping;

import java.util.HashMap;
import java.util.Map;


public class Cart {

    private Map<String, Clothes> cart;

    public Cart() {
    }

    public Cart(Map<String, Clothes> cart) {
        this.cart = cart;
    }

    public Map<String, Clothes> getCart() {
        return cart;
    }

    public void setCart(Map<String, Clothes> cart) {
        this.cart = cart;
    }

    public boolean add(Clothes clothes) {

        boolean check = false;
        try {
            if (this.cart == null) {
                this.cart = new HashMap<>();
            }
            if (this.cart.containsKey(clothes.getId())) {
                int currentQuantity = this.cart.get(clothes.getId()).getQuantity();
                this.cart.get(clothes.getId()).setQuantity(currentQuantity + clothes.getQuantity());
            } else {
                cart.put(clothes.getId(), clothes);
            }

            check = true;
        } catch (Exception e) {

        }

        return check;
    }

    public boolean remove(String id) {
        boolean check = false;
        try {
            if (this.cart != null) {
                if (this.cart.containsKey(id)) {
                    this.cart.remove(id);

                    check = true;
                }
            }

        } catch (Exception e) {

        }

        return check;
    }

    public boolean editQuantity(String id, int quantity) {
        boolean check = false;
        try {
            if (this.cart != null) {
                if (this.cart.containsKey(id)) {
                    this.cart.get(id).setQuantity(quantity);
                    check = true;
                }
            }

        } catch (Exception e) {

        }

        return check;
    }

    public boolean checkitem(String id) {
        boolean check = false;
        try {
            if (this.cart != null) {

                if (this.cart.containsKey(id)) {
                    check = true;

                }
            }
        } catch (Exception e) {

        }
        return check;
    }

    public int checkquantityforitem(String id) {
        int quantity = 0;
        try {
            if (this.cart != null) {
                if (this.cart.containsKey(id)) {
                    quantity = this.cart.get(id).getQuantity();

                }
            }
        } catch (Exception e) {

        }
        return quantity;
    }

}
