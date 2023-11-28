package com.example.service;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.datastax.oss.driver.api.core.CqlSession;
import com.datastax.oss.driver.api.core.config.DriverConfigLoader;
import com.datastax.oss.driver.api.core.cql.PreparedStatement;


import com.example.entity.Filter;

@Service
public class FliterServiceImpl implements FilterService {

	@Override
	public void insertFilter(String username) {
		// TODO Auto-generated method stub
		Path configPath = Paths.get("c:/keys/keyspace/application.conf");
		DriverConfigLoader loader = DriverConfigLoader.fromPath(configPath);
		Filter filter = new Filter();
		List<Integer> list = Arrays.asList(0, 0);
		String gender = "Male";
		int maximum_distance = 0;
		filter.setUsername(username);
		filter.setAge_range(list);
		filter.setGender(gender);
		filter.setMaximum_distance(maximum_distance);
		
		try (CqlSession session = CqlSession.builder().withConfigLoader(loader).build()) {
			//INSERT INTO your_table_name (id, list_field, gender, maximum_distance) 
			//VALUES (uuid(), [20, 40], 'Male', 100);
			String cql = "insert into member.filter (username, age_range, gender, maximum_distance) values (? , ? , ?, ?)";
			PreparedStatement preparedStatement = session.prepare(cql);
			session.execute(preparedStatement.bind(username,list,gender,maximum_distance));		
		}catch (Exception e) {
			// TODO: handle exception
			System.out.println(e + " 에러..");
		}
	}
	@Override
	public void joinFilter(String username) {
		// TODO Auto-generated method stub
		Path configPath = Paths.get("c:/keys/keyspace/application.conf");
		DriverConfigLoader loader = DriverConfigLoader.fromPath(configPath);
		Filter filter = new Filter();
		List<Integer> list = Arrays.asList(0, 0);
		String gender = "Male";
		int maximum_distance = 0;
		filter.setUsername(username);
		filter.setAge_range(list);
		filter.setGender(gender);
		filter.setMaximum_distance(maximum_distance);
		
		try (CqlSession session = CqlSession.builder().withConfigLoader(loader).build()) {
			//INSERT INTO your_table_name (id, list_field, gender, maximum_distance) 
			//VALUES (uuid(), [20, 40], 'Male', 100);
			String cql = "insert into member.filter (username, age_range, gender, maximum_distance) values (? , ? , ?, ?)";
			PreparedStatement preparedStatement = session.prepare(cql);
			session.execute(preparedStatement.bind(username,list,gender,maximum_distance));		
		}catch (Exception e) {
			// TODO: handle exception
			System.out.println(e + " 에러..");
		}
	}
	@Override
	public void updateFilter(Filter filter) {
		// TODO Auto-generated method stub
		Path configPath = Paths.get("c:/keys/keyspace/application.conf");
		DriverConfigLoader loader = DriverConfigLoader.fromPath(configPath);
		
		try (CqlSession session = CqlSession.builder().withConfigLoader(loader).build()) {
			//INSERT INTO your_table_name (id, list_field, gender, maximum_distance) 
			//VALUES (uuid(), [20, 40], 'Male', 100);
			String cql = "update member.filter set age_range = ?, gender = ?, maximum_distance = ? where username = ?";
			PreparedStatement preparedStatement = session.prepare(cql);
			session.execute(preparedStatement.bind(filter.getAge_range(),filter.getGender(),filter.getMaximum_distance(),filter.getUsername()));
			
		}catch (Exception e) {
			// TODO: handle exception
			System.out.println(e + " 에러..");
		}
		
	}
	
	
	
}
