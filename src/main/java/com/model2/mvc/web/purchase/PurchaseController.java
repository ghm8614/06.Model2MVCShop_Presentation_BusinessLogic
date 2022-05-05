package com.model2.mvc.web.purchase;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.purchase.impl.PurchaseServiceImpl;

@Controller
public class PurchaseController {

	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	// C
	public PurchaseController() {
		System.out.println(this.getClass());
	}

	// AddPurchaseViewAction.java
	@RequestMapping("/addPurchaseView.do")
	public String addPurchaseView(@RequestParam("prod_no") int prodNo, Model model) throws Exception {

		Product product = productService.findProduct(prodNo);

		model.addAttribute("product", product);
		
		return "forward:/purchase/addPurchase.jsp";
	}

	// AddPurchaseAction.java
	@RequestMapping("/addPurchase.do")
	public String addPurchase(@RequestParam("prodNo") int prodNo, @RequestParam("buyerId") String buyerId,
			@ModelAttribute("purchase") Purchase purchase, HttpSession session) throws Exception {
		
		Product product = productService.findProduct(prodNo);
		
		User user = (User) session.getAttribute("user");
		
		purchase.setPurchaseProd(product);
		purchase.setBuyer(user);
		purchase.setTranCode("1");	// 구매 : tranCode : null -> "1"
		
		purchaseService.addPurchase(purchase);
		
		return "forward:/purchase/addPurchaseView.jsp";
	}
	
	
	// ListPurchaseAction.java
	@RequestMapping("/listPurchase.do")
	public String listPurchase(@ModelAttribute("search") Search search,
			@RequestParam(value = "menu", required = false) String menu,
			Model model, HttpSession session)
			throws Exception {

		if(search.getCurrentPage() == 0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);

		User user = (User) session.getAttribute("user");
		Map<String, Object> map = purchaseService.getPurchaseList(search, user.getUserId());

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);

		model.addAttribute("search", search);
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("list", map.get("list"));

		return "forward:/purchase/listPurchase.jsp";
	}
	
	// UpdatePurchaseViewAction.java
	@RequestMapping("/updatePurchaseView.do")
	public String updatePurchase(@RequestParam("tranNo") int tranNo, Model model) throws Exception {
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/updatePurchase.jsp";
	}
	
	// UpdatePurchaseAction.java
	@RequestMapping("/updatePurchase.do")
	public String updatePurchase(@RequestParam("tranNo") int tranNo, HttpSession session,
			@ModelAttribute("purchase") Purchase purchase) throws Exception {
		
		User user = (User) session.getAttribute("user");
		purchase.setBuyer(user);
		
		purchaseService.updatePurchase(purchase);
		
		return "forward:/getPurchase.do?tranNo=" + tranNo;
	}
	
	// GetPurchaseAction.java
	@RequestMapping("/getPurchase.do")
	public String getPurchase(@RequestParam("tranNo") int tranNo, Model model) throws Exception {
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/readPurchase.jsp";
	}
	

	// UpdateTranCodeByProdAction.java
	// 배송하기
	@RequestMapping("/updateTranCodeByProd.do")
	public String updateTranCodeByProd(@RequestParam("prodNo") int prodNo, @RequestParam("tranCode") String tranCode)
			throws Exception {

		Product product = new Product();
		product.setProdNo(prodNo);

		Purchase purchase = new Purchase();
		purchase.setPurchaseProd(product);
		purchase.setTranCode(tranCode); // 2 고정

		purchaseService.updateTranCode(purchase);

		return "forward:/listProduct.do?menu=manage";
	}

	// UpdateTranCodeAction.java
	// 물건도착
	@RequestMapping("/updateTranCode.do")
	public String updateTranCode(@RequestParam("tranNo") int tranNo, @RequestParam("tranCode") String tranCode)
			throws Exception {

		System.out.println("///////////////tranNo : "+tranNo);
		System.out.println("///////////////tranCode : "+tranCode);
		
		Purchase purchase = new Purchase();
		purchase.setTranNo(tranNo);
		purchase.setTranCode(tranCode);// 3 고정
		
		System.out.println("///////////////purchase : "+purchase);
		purchaseService.updateTranCode(purchase);
		System.out.println("///////////////purchase : "+purchase);

		return "forward:/listPurchase.do";
	}





}
