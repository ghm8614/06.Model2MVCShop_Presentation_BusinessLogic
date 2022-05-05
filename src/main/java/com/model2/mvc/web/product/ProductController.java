package com.model2.mvc.web.product;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

@Controller
public class ProductController {

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	// C
	public ProductController() {
		System.out.println(this.getClass());

	}

	@RequestMapping("/addProduct.do")
	public String addProduct(@ModelAttribute("product") Product product) throws Exception {
		
		System.out.println("컨트롤러에서의 "+product);
		product.setManuDate(product.getManuDate().replace("-", ""));

		productService.insertProduct(product);

		return "redirect:/product/addProductView.jsp";
	}

	@RequestMapping("/listProduct.do")
	public String listProduct(@ModelAttribute("search") Search search,
			@RequestParam(value = "menu", required = false) String menu, Model model) throws Exception {

		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map = productService.getProductList(search);
		Page resultPage = new Page(search.getCurrentPage(), (int) map.get("totalCount"), pageUnit, pageSize);

		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("menu", menu);
		
		return "forward:/product/listProduct.jsp";
	}

	@RequestMapping("/getProduct.do")
	public String getProduct(@RequestParam("prodNo") int prodNo, Model model) throws Exception {
		System.out.println("prodNo :" + prodNo);

		Product product = productService.findProduct(prodNo);
		model.addAttribute("product", product);

		return "forward:/product/readProduct.jsp";
	}

	@RequestMapping("/updateProduct.do")
	public String updateProduct(@RequestParam("prodNo") String prodNo, @ModelAttribute("product") Product product)
			throws Exception {

		productService.updateProduct(product);
		
		return "redirect:/getProduct.do?prodNo=" + prodNo;
	}
	
	
	@RequestMapping("/updateProductView.do")
	public String updateProduct(@RequestParam("prodNo") int prodNo, Model model)
			throws Exception {

		Product product = productService.findProduct(prodNo);
		model.addAttribute("product", product);
		
		return "forward:/product/updateProductView.jsp";
	}

}
