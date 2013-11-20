package com.amfitel.m2000.ae.tests.xslt;

import java.io.File;

import javax.xml.transform.Source;
import javax.xml.transform.TransformerException;
import javax.xml.transform.URIResolver;
import javax.xml.transform.stream.StreamSource;

public class Resolver implements URIResolver {

	public Source resolve(String href, String base) throws TransformerException {
		return new StreamSource(new File("xsl/" + href));
	}
}
