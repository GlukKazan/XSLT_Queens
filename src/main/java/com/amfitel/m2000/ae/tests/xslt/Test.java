package com.amfitel.m2000.ae.tests.xslt;

import java.io.File;
import java.io.FileInputStream;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Result;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMResult;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.sax.SAXSource;
import javax.xml.transform.sax.SAXTransformerFactory;
import javax.xml.transform.sax.TransformerHandler;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;

import org.apache.xpath.XPathAPI;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.traversal.NodeIterator;
import org.xml.sax.ContentHandler;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.XMLReader;
import org.xml.sax.helpers.AttributesImpl;
import org.xml.sax.helpers.XMLReaderFactory;

public class Test {
	
	private final static String JAVAX_TRANSFORM_FACTORY = "javax.xml.transform.TransformerFactory";
	private final static String SAXON_TRANSFORM_FACTORY = "net.sf.saxon.TransformerFactoryImpl";
	private final static String XALAN_TRANSFORM_FACTORY = "org.apache.xalan.processor.TransformerFactoryImpl";
	
	public static void main(String[] args) {
		Test t = new Test();
		try {
			t.test_full("4");
		} catch (Exception e) {
			System.out.println(e.toString());
		}
	}
	
	private void test_xpath_dom() throws Exception {
		System.setProperty(JAVAX_TRANSFORM_FACTORY, XALAN_TRANSFORM_FACTORY);
		InputSource in = new InputSource(new FileInputStream("xml/data.xml"));
		DocumentBuilderFactory df = DocumentBuilderFactory.newInstance();
		Document doc = df.newDocumentBuilder().parse(in);
		
		NodeIterator nl = XPathAPI.selectNodeIterator(doc, "/size");
		Node n;
	    while ((n = nl.nextNode())!= null) {
	    	if (n.getNodeType() == Node.TEXT_NODE) {
	    		System.out.println(n.getNodeValue());
	    	} else {
	    		System.out.println(n.getTextContent());
	    	}
	    }
	}

	private void test_xpath_sax_file() throws Exception {
		System.setProperty(JAVAX_TRANSFORM_FACTORY, XALAN_TRANSFORM_FACTORY);
		TransformerFactory tf = TransformerFactory.newInstance();
	    if (tf.getFeature(SAXSource.FEATURE) && tf.getFeature(DOMResult.FEATURE)) {
	        SAXTransformerFactory stf = (SAXTransformerFactory)tf;	  
	        TransformerHandler h = stf.newTransformerHandler();
	    	XMLReader reader = XMLReaderFactory.createXMLReader();
	        reader.setContentHandler(h);
	        reader.setProperty("http://xml.org/sax/properties/lexical-handler", h);

			DocumentBuilderFactory df = DocumentBuilderFactory.newInstance();
			Document doc = df.newDocumentBuilder().newDocument();
			Result out = new DOMResult(doc);
			h.setResult(out);
			reader.parse("xml/data.xml");
	        
	        XPathFactory xpathFactory = XPathFactory.newInstance();
	        XPath xpath = xpathFactory.newXPath();
	        XPathExpression xpathExpression = xpath.compile("/size");
	        System.out.println(xpathExpression.evaluate(doc));
	    } else {
	    	throw new Exception("Can''t support SAXSource or DOMResult");
	    }
	}
	
	private void generateData(ContentHandler h, String data) throws SAXException {
		h.startDocument();
		h.startElement("", "size", "size", new AttributesImpl());
		h.characters(data.toCharArray(), 0, data.length());
		h.endElement("", "size", "size");
		h.endDocument();
	}
	

	private void test_xpath_sax_stream(String size) throws Exception {
		System.setProperty(JAVAX_TRANSFORM_FACTORY, XALAN_TRANSFORM_FACTORY);
		TransformerFactory tf = TransformerFactory.newInstance();
	    if (tf.getFeature(SAXSource.FEATURE) && tf.getFeature(DOMResult.FEATURE)) {
	        SAXTransformerFactory stf = (SAXTransformerFactory)tf;	  
	        TransformerHandler h = stf.newTransformerHandler();

			DocumentBuilderFactory df = DocumentBuilderFactory.newInstance();
			Document doc = df.newDocumentBuilder().newDocument();
			Result out = new DOMResult(doc);
			h.setResult(out);
			generateData(h, size);
	        
	        XPathFactory xpathFactory = XPathFactory.newInstance();
	        XPath xpath = xpathFactory.newXPath();
	        XPathExpression xpathExpression = xpath.compile("/size");
	        System.out.println(xpathExpression.evaluate(doc));
	    } else {
	    	throw new Exception("Can''t support SAXSource or DOMResult");
	    }
	}
	
	private void test_solution(String size) throws Exception {
		System.setProperty(JAVAX_TRANSFORM_FACTORY, XALAN_TRANSFORM_FACTORY);
		TransformerFactory tf = TransformerFactory.newInstance();
	    if (tf.getFeature(SAXSource.FEATURE) && tf.getFeature(SAXResult.FEATURE)) {
	        SAXTransformerFactory stf = (SAXTransformerFactory)tf;	  
	        TransformerHandler solve  = stf.newTransformerHandler(new StreamSource("xsl/solution.xsl"));
	        TransformerHandler filter = stf.newTransformerHandler();
	        TransformerHandler view   = stf.newTransformerHandler();
	        Result result = new StreamResult(new File("xml/result.xml"));
	        
	        solve.setResult(new SAXResult(filter));
	        filter.setResult(new SAXResult(view));
	        view.setResult(result);
			generateData(solve, size);
	    } else {
	    	throw new Exception("Can''t support SAXSource or SAXResult");
	    }
	}

	private void test_queens(String size) throws Exception {
		System.setProperty(JAVAX_TRANSFORM_FACTORY, XALAN_TRANSFORM_FACTORY);
		TransformerFactory tf = TransformerFactory.newInstance();
		tf.setURIResolver(new Resolver());
	    if (tf.getFeature(SAXSource.FEATURE) && tf.getFeature(SAXResult.FEATURE)) {
	        SAXTransformerFactory stf = (SAXTransformerFactory)tf;	  
	        TransformerHandler solve  = stf.newTransformerHandler(new StreamSource("xsl/queens.xsl"));
	        TransformerHandler filter = stf.newTransformerHandler();
	        TransformerHandler view   = stf.newTransformerHandler(new StreamSource("xsl/boards.xsl"));
	        Result result = new StreamResult(new File("xml/result.html"));
	        
	        solve.setResult(new SAXResult(filter));
	        filter.setResult(new SAXResult(view));
	        view.setResult(result);
			generateData(solve, size);
	    } else {
	    	throw new Exception("Can''t support SAXSource or SAXResult");
	    }
	}
	
	private void test_full(String size) throws Exception {
		System.setProperty(JAVAX_TRANSFORM_FACTORY, SAXON_TRANSFORM_FACTORY);
		TransformerFactory tf = TransformerFactory.newInstance();
		tf.setURIResolver(new Resolver());
	    if (tf.getFeature(SAXSource.FEATURE) && tf.getFeature(SAXResult.FEATURE)) {
	        SAXTransformerFactory stf = (SAXTransformerFactory)tf;	  
	        TransformerHandler solve  = stf.newTransformerHandler(new StreamSource("xsl/queens.xsl"));
	        TransformerHandler filter = stf.newTransformerHandler(new StreamSource("xsl/distinct.xsl"));
	        TransformerHandler view   = stf.newTransformerHandler(new StreamSource("xsl/count.xsl"));
	        Result result = new StreamResult(new File("xml/result.xml"));
	        
	        solve.setResult(new SAXResult(filter));
	        filter.setResult(new SAXResult(view));
	        view.setResult(result);
	        
	        Long timestamp = System.currentTimeMillis();
			generateData(solve, size);
			System.out.println("Elapsed Time: " + Long.toString(System.currentTimeMillis() - timestamp));
	    } else {
	    	throw new Exception("Can''t support SAXSource or SAXResult");
	    }
	}
}
