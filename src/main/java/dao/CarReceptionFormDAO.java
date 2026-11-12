// File: CarReceptionFormDAO.java
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import model.*;

public class CarReceptionFormDAO extends DAO {
    public CarReceptionFormDAO() {
        super();
    }

    public CarReceptionForm createReceptionForm(CarOwner carOwner, List<ServiceRequest> serviceRequests,
            List<SparePartRequest> sparePartRequests, Technician technician) {
        CarReceptionForm form = new CarReceptionForm();
        form.setCarOwner(carOwner);
        form.setServiceRequests(serviceRequests);
        form.setSparePartRequests(sparePartRequests);
        form.setTechnician(technician);
        return form;
    }

    public boolean saveReceptionForm(CarReceptionForm form) {
        boolean kq = false;
        try {
            con.setAutoCommit(false);
            String sqlCO = "INSERT INTO tblCarOwner(customerId, carId, responsibility) VALUES (?, ?, ?)";
            PreparedStatement psCO = con.prepareStatement(sqlCO, PreparedStatement.RETURN_GENERATED_KEYS);
            psCO.setInt(1, form.getCarOwner().getCustomer().getId());
            psCO.setInt(2, form.getCarOwner().getCar().getId());
            psCO.setString(3, form.getCarOwner().getResponsibility());
            psCO.executeUpdate();
            ResultSet rsCO = psCO.getGeneratedKeys();
            int carOwnerId = 0;
            if (rsCO.next())
                carOwnerId = rsCO.getInt(1);

            String sqlForm = "INSERT INTO tblCarReceptionForm(carOwnerId, technicianId, receptionTime) VALUES (?, ?, NOW())";
            PreparedStatement psForm = con.prepareStatement(sqlForm, PreparedStatement.RETURN_GENERATED_KEYS);
            psForm.setInt(1, carOwnerId);
            psForm.setInt(2, form.getTechnician().getTechnicianId());
            psForm.executeUpdate();
            ResultSet rsForm = psForm.getGeneratedKeys();
            int formId = 0;
            if (rsForm.next())
                formId = rsForm.getInt(1);

            if (form.getServiceRequests() != null) {
                String sqlSR = "INSERT INTO tblServiceRequest(carReceptionFormId, serviceId, unitPrice, totalAmount) VALUES (?, ?, ?, ?)";
                for (ServiceRequest sr : form.getServiceRequests()) {
                    PreparedStatement psSR = con.prepareStatement(sqlSR);
                    psSR.setInt(1, formId);
                    psSR.setInt(2, sr.getService().getId());
                    psSR.setFloat(3, sr.getService().getPrice());
                    psSR.setFloat(4, sr.getService().getPrice());
                    psSR.executeUpdate();
                }
            }
            if (form.getSparePartRequests() != null) {
                String sqlPR = "INSERT INTO tblSparePartRequest(carReceptionFormId, sparePartId, quantity, unitPrice, totalAmount) VALUES (?, ?, ?, ?, ?)";
                for (SparePartRequest pr : form.getSparePartRequests()) {
                    PreparedStatement psPR = con.prepareStatement(sqlPR);
                    psPR.setInt(1, formId);
                    psPR.setInt(2, pr.getSparePart().getId());
                    psPR.setInt(3, pr.getQuantity());
                    psPR.setFloat(4, pr.getSparePart().getPrice());
                    psPR.setFloat(5, pr.getQuantity() * pr.getSparePart().getPrice());
                    psPR.executeUpdate();
                }
            }
            con.commit();
            kq = true;
        } catch (Exception e) {
            try {
                con.rollback();
            } catch (Exception ex) {
            }
            e.printStackTrace();
        } finally {
            try {
                con.setAutoCommit(true);
            } catch (Exception ex) {
            }
        }
        return kq;
    }
}