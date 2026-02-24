package com.project.cepat.kelar.jpa.repository.common;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Repository;

@Repository
public class CustomRepositoryUtil<T> {

    static Logger logger = LoggerFactory.getLogger(CustomRepositoryUtil.class);

    private String queryIdentifier;
    private Class<T> clazz;

    /**
     * Method to set Domain class
     *
     * @param clazzToSet entity class
     */
    public void setClazz(final Class<T> clazzToSet) {
        clazz = clazzToSet;
    }

    public void setQueryIdentifier(String queryIdentifier) {
        this.queryIdentifier = queryIdentifier;
    }

    public String constructQuery(String baseQuery, List<Map<String, Object>> mapParam, Pageable pageable) {
        StringBuilder queryAppend = new StringBuilder(baseQuery);
        defineQueryIdentifier(baseQuery);
        int x = 0;
        if (mapParam.size() > 0) {
            queryAppend.append(" where ");
            for (Map<String, Object> filter : mapParam) {
                if (x > 0) {
                    queryAppend.append(" and ");
                }
                if(filter.size() == 1){
                    for (Map.Entry<String, Object> entry : filter.entrySet()) {
                        try {
                            queryAppend.append(" " + queryIdentifier + ".").append(entry.getKey()).append(getFieldDataType(entry.getKey(), entry.getValue()));
                        } catch (Exception e) {
                            logger.error("Fail constructQuery", e);
                        }
                    }
                    x++;
                }
                else if(filter.size() == 3){ //its range filter
                    logger.info("Search By : " + filter.toString());
                    //filter.get("")
                }
            }

            Iterator<Sort.Order> itr = pageable.getSort().iterator();
            while (itr.hasNext()) {
                Sort.Order order = itr.next();
                queryAppend.append(" order by " + queryIdentifier + "." + order.getProperty() + " " + order.getDirection());
            }
        } else {
            Iterator<Sort.Order> itr = pageable.getSort().iterator();
            while (itr.hasNext()) {
                Sort.Order order = (Sort.Order) itr.next();
                queryAppend.append(" order by " + queryIdentifier + "." + order.getProperty() + " " + order.getDirection());
            }
        }
        return queryAppend.toString();
    }

    private void defineQueryIdentifier(String selectQuery) {
        if (selectQuery.startsWith("select")) {
            this.setQueryIdentifier(selectQuery.split(" ")[1]);
        } else {
            logger.info("Query is not recognized");
        }
    }

    private String getFieldDataType(String fieldName, Object fieldValue) throws Exception {
        String sReturn = "";
        if (!fieldName.contains(".")) {
            for (Field field : clazz.getDeclaredFields()) {
                if (fieldName.equals(field.getName())) {
//                    logger.info(" field Type of " + field.getName() + " is " + field.getType());
                    if (getFieldCustomDataType(field.getType().getName())) { //customDataType that contained in com.pst.whee.pos.backend.constants package
                        sReturn = " ='" + fieldValue + "'";
                        break;
                    } else if (field.getType().equals(String.class)) {
                        sReturn = " like '%" + fieldValue + "%'";
                        break;
                    } else if (field.getType().equals(Integer.class) || field.getType().equals(Long.class)) {
                        sReturn = " =" + fieldValue;
                        break;
                    } else if (field.getType().equals(Boolean.class)) {
                        sReturn = " is " + fieldValue;
                        break;
                    } else {
                        sReturn = " like '%" + fieldValue + "%'"; //default
                        break;
                    }
                }
            }

            //check field on superClass
            for(Field field : clazz.getSuperclass().getDeclaredFields()){
                if (fieldName.equals(field.getName())) {
//                    logger.info(" field Type of " + field.getName() + " is " + field.getType());
                    if (getFieldCustomDataType(field.getType().getName())) { //customDataType that contained in com.pst.whee.pos.backend.constants package
                        sReturn = " ='" + fieldValue + "'";
                        break;
                    } else if (field.getType().equals(String.class)) {
                        sReturn = " like '%" + fieldValue + "%'";
                        break;
                    } else if (field.getType().equals(Integer.class) || field.getType().equals(Long.class)) {
                        sReturn = " =" + fieldValue;
                        break;
                    } else if (field.getType().equals(Boolean.class)) {
                        sReturn = " is " + fieldValue;
                        break;
                    } else {
                        sReturn = " like '%" + fieldValue + "%'"; //default
                        break;
                    }
                }
            }
        }else{
            sReturn = " like '%" + fieldValue + "%'"; //default
        }
        return sReturn;
    }

    /**
     * <p>Function to compare if a given field name is member of any class in <b>com.pst.whee.pos.backend.constants</b> package</p>
     *
     * @param fieldType dataType of a field checked
     * @return true or false
     */
    private Boolean getFieldCustomDataType(String fieldType) {

        Boolean bReturn = false;
        String basePackage = "com.pst.whee.pos.backend.constants.";
        List<String> listClass = new ArrayList<>();
        listClass.add(basePackage + "EmployeeType");
        listClass.add(basePackage + "Gender");
        listClass.add(basePackage + "GeneralStatus");
        listClass.add(basePackage + "GiftCardStatus");
        listClass.add(basePackage + "PaymentKind");
        listClass.add(basePackage + "ProductStatus");
        listClass.add(basePackage + "StockControlStatus");
        listClass.add(basePackage + "StockControlType");
        listClass.add(basePackage + "StoreStatus");
        listClass.add(basePackage + "TransactionStatus");

        for (String strClass : listClass) {
            if (fieldType.equals(strClass)) {
                bReturn = true;
                break;
            }
        }
        return bReturn;
    }

}
