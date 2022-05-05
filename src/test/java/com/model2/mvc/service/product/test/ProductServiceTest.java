package com.model2.mvc.service.product.test;

import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;

import junit.framework.Assert;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/commonservice.xml" })
public class ProductServiceTest {

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;

	// @Test
	public void testAddProduct() throws Exception {

		Product product = new Product();

		product.setProdName("TestProduct");
		product.setProdDetail("TestProduct");
		product.setManuDate("20220401");
		product.setPrice(1);
		product.setFileName("TestProduct.jpg");
		System.out.println(product);

		productService.insertProduct(product);

		product = productService.findProduct(10029);
		// System.out.println(product);

		Assert.assertEquals("TestProduct", product.getProdName());
	}

	// @Test
	public void testGetProduct() throws Exception {

		Product product = new Product();

		product = productService.findProduct(10029);

		Assert.assertEquals("TestProduct", product.getProdName());
		Assert.assertEquals("TestProduct", product.getProdDetail());
		Assert.assertEquals("20220401", product.getManuDate());
		Assert.assertEquals(1, product.getPrice());
		Assert.assertEquals("TestProduct.jpg", product.getFileName());
	}

	// @Test
	public void testUpdateProduct() throws Exception {

		Product product = new Product();

		product = productService.findProduct(10029);

		if (product.getProdName().equals("TestProduct")) {
			product.setProdName("TestProductChanege");
			product.setProdDetail("TestProductChanege");

			productService.updateProduct(product);
		}

		product = productService.findProduct(10029);
		Assert.assertEquals("TestProductChanege", product.getProdName());
		Assert.assertEquals("TestProductChanege", product.getProdDetail());

	}

	//@Test
	public void testGetProductListAll() throws Exception {

		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(5);
		Map<String, Object> map = productService.getProductList(search);

		List<Product> list = (List<Product>) map.get("list");

		// Search�� Page ������ db���� ������ data ����
		// pageSize�� �Խù� 5���� ���������Ƿ�, db���� 5���� �����´�.
		Assert.assertEquals(5, list.size());

		// totalCount : Search ������ �̻��� db�� �ִ� product �� ����
		// int Ÿ��������, map�� ����ɶ� Object Ÿ������ ����ǹǷ�, �������� ����ȯ �ʿ�
		Assert.assertEquals(23, (int) map.get("totalCount"));
	}

	//@Test
	public void testGetProductListByProdNo() throws Exception {

		Search search = new Search();

		search.setCurrentPage(1);
		search.setPageSize(3);

		search.setSearchCondition("0");
		search.setSearchKeyword("10010"); // ��Ʈ��

		Map<String, Object> map = productService.getProductList(search);

		List<Product> list = (List<Product>) map.get("list");

		// Page ������ db���� ������ ������ ����
		Assert.assertEquals(1, list.size());

		// Search ������ db�� ������ִ� ������ �� ����
		Assert.assertEquals(1, (int) map.get("totalCount"));

		// ��� 1. totalCount > list.size
		// ���� Search ������ db���� ã�� �������� totalCount�� 10����
		// pageSize = 3 �̶��, �� �� �������� 3���� �����͸� display �Ѵٸ�
		// 3���� list �� db���� �����´�?

		// ��� 2. totalCount < list.size
		// ���� Search ������ db���� ã�� �������� totalCount�� 2���̰�
		// pageSize = 3 �̶��, �� �� �������� 3���� �����͸� display �Ѵٸ�
		// 2���� list �� db���� �����´�?

	}

	//@Test
	public void testGetProductListByProdName() throws Exception {

		Search search = new Search();

		search.setCurrentPage(1);
		search.setPageSize(3);
		search.setSearchCondition("1");
		search.setSearchKeyword("��%"); // ���콺, ���콺, ����ũ, ���콺22 : �� 4��

		System.out.println(search);
		Map<String, Object> map = productService.getProductList(search);

		List<Product> list = (List<Product>) map.get("list");
		System.out.println(list);

		// db���� ������ ������ ������ ���� : 3��, �˻����ǿ� ���� ������ �� ���� : 4�� 
		Assert.assertEquals(3, list.size());
		Assert.assertEquals(4, (int) map.get("totalCount"));

	}

	@Test
	public void testGetProductListByPrice() throws Exception {

		Search search = new Search();

		search.setCurrentPage(1);
		search.setPageSize(3);
		search.setSearchCondition("2");
		search.setSearchKeyword("1000"); // ���� 1000���� ��ǰ : 2��  

		Map<String, Object> map = productService.getProductList(search);

		List<Product> list = (List<Product>) map.get("list");

		Assert.assertEquals(2, list.size());
		Assert.assertEquals(2, (int) map.get("totalCount"));

	}

}
