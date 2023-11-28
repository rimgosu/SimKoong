package com.example.service;

import com.example.entity.Filter;

public interface FilterService {
	public void insertFilter(String username);
	
	public void updateFilter(Filter filter);

	public void joinFilter(String username);

}
