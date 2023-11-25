package com.example.service;

import java.lang.reflect.Field;
import java.util.List;
import java.util.Map;

import com.datastax.oss.driver.api.core.config.DriverConfigLoader;
import com.datastax.oss.driver.api.core.cql.Row;


public interface DBService {
	
	// 카산드라 데이터베이스에 접속
	public DriverConfigLoader getConnection();
	
	<T> void save(DriverConfigLoader loader, Class<T> entityClass, T entity);
	
	public <T> List<T> findAll(DriverConfigLoader loader, Class<T> classType);
	<T> List<T> findAllByColumnValue(DriverConfigLoader loader, Class<T> classType, String columnName, Object value);
	<T> List<T> findAllByColumnValues(DriverConfigLoader loader, Class<T> classType,
			Map<String, Object> columnValues);
	
	<T> void updateByColumnValues(DriverConfigLoader loader, Class<T> classType, 
            Map<String, Object> updateValues, Map<String, Object> whereConditions);
	
	
	public <T> void setFieldValue(Field field, T entity, Row row) throws IllegalAccessException;


}