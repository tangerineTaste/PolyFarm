package com;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class Cart {
    private List<Item> items;

    public Cart() {
        items = new ArrayList<>();
    }

    public void addItem(Item item) {
        items.add(item);
    }

    public void removeItem(int id) {
        Iterator<Item> iterator = items.iterator();
        while (iterator.hasNext()) {
            Item item = iterator.next();
            if (item.getId() == id) {
                iterator.remove();
                break;
            }
        }
    }

    public List<Item> getItems() {
        return items;
    }

    public int getTotalPrice() {
        return items.stream().mapToInt(Item::getPrice).sum();
    }
}




