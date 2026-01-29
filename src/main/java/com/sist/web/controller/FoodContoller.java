package com.sist.web.controller;
import java.util.*;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sist.web.vo.*;

import lombok.RequiredArgsConstructor;

import com.sist.web.service.*;

@Controller
@RequiredArgsConstructor
public class FoodContoller {
	private final FoodService fService;
	
	@GetMapping("/")
	public String food_list(@RequestParam(value="page",required = false)String page,Model model)
	{
		if(page==null)
			page="1";
		int curPage = Integer.parseInt(page);
		List<FoodVO> list = fService.foodListData((curPage-1)*12);
		int startPage= ((curPage-1)/10*10)+1;
		int endPage= ((curPage-1)/10*10)+10;
		int totalPage= fService.foodTotalPage();
		if(endPage>totalPage)
			endPage=totalPage;
		
		model.addAttribute("list", list);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("curPage", curPage);
		return "list";
	}
	@GetMapping("/detail")
	public String food_detail(@RequestParam("fno")int fno,Model model)
	{
		FoodVO vo = fService.foodDetailData(fno);
		model.addAttribute("vo", vo);
		return "detail";
	}
}
