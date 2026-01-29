package com.sist.web.service;
import java.util.List;

import org.springframework.stereotype.Service;

import com.sist.web.mapper.*;
import com.sist.web.vo.FoodVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class FoodServiceImpl implements FoodService{
	private final FoodMapper fMapper;
	
	@Override
	public FoodVO foodDetailData(int fno) {
		// TODO Auto-generated method stub
		fMapper.foodHitIncrement(fno);
		return fMapper.foodDetailData(fno);
	}
	@Override
	public List<FoodVO> foodFindData(int start, String address) {
		// TODO Auto-generated method stub
		return fMapper.foodFindData(start, address);
	}
	@Override
	public int foodFindTotalPage(String address) {
		// TODO Auto-generated method stub
		return fMapper.foodFindTotalPage(address);
	}
	@Override
	public List<FoodVO> foodListData(int start) {
		// TODO Auto-generated method stub
		return fMapper.foodListData(start);
	}
	@Override
	public int foodTotalPage() {
		// TODO Auto-generated method stub
		return fMapper.foodTotalPage();
	}
}
