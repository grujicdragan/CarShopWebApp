package main;
// Generated Sep 1, 2019 9:18:07 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * Car generated by hbm2java
 */
public class Car  implements java.io.Serializable {


     private Integer id;
     private Color color;
     private LevelOfEquipment levelOfEquipment;
     private Location location;
     private Model model;
     private Set<Order> orders = new HashSet<Order>(0);

    public Car() {
    }

	
    public Car(Color color, LevelOfEquipment levelOfEquipment, Location location, Model model) {
        this.color = color;
        this.levelOfEquipment = levelOfEquipment;
        this.location = location;
        this.model = model;
    }
    public Car(Color color, LevelOfEquipment levelOfEquipment, Location location, Model model, Set<Order> orders) {
       this.color = color;
       this.levelOfEquipment = levelOfEquipment;
       this.location = location;
       this.model = model;
       this.orders = orders;
    }
   
    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    public Color getColor() {
        return this.color;
    }
    
    public void setColor(Color color) {
        this.color = color;
    }
    public LevelOfEquipment getLevelOfEquipment() {
        return this.levelOfEquipment;
    }
    
    public void setLevelOfEquipment(LevelOfEquipment levelOfEquipment) {
        this.levelOfEquipment = levelOfEquipment;
    }
    public Location getLocation() {
        return this.location;
    }
    
    public void setLocation(Location location) {
        this.location = location;
    }
    public Model getModel() {
        return this.model;
    }
    
    public void setModel(Model model) {
        this.model = model;
    }
    public Set<Order> getOrders() {
        return this.orders;
    }
    
    public void setOrders(Set<Order> orders) {
        this.orders = orders;
    }




}

