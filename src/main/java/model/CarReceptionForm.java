package model;

import java.util.List;

public class CarReceptionForm {
    private CarOwner carOwner;
    private List<ServiceRequest> serviceRequests;
    private List<SparePartRequest> sparePartRequests;
    private Technician technician;

    public void setCarOwner(CarOwner carOwner) {
        this.carOwner = carOwner;
    }

    public CarOwner getCarOwner() {
        return carOwner;
    }

    public void setServiceRequests(List<ServiceRequest> serviceRequests) {
        this.serviceRequests = serviceRequests;
    }

    public List<ServiceRequest> getServiceRequests() {
        return serviceRequests;
    }

    public void setSparePartRequests(List<SparePartRequest> sparePartRequests) {
        this.sparePartRequests = sparePartRequests;
    }

    public List<SparePartRequest> getSparePartRequests() {
        return sparePartRequests;
    }

    public void setTechnician(Technician technician) {
        this.technician = technician;
    }

    public Technician getTechnician() {
        return technician;
    }
}