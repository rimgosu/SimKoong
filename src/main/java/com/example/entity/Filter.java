package com.example.entity;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Filter {
	private String username;
	private List<Integer> age_range;
	private String gender;
	private int maximum_distance;
}
