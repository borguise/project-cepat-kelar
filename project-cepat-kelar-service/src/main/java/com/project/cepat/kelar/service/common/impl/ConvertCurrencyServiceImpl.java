package com.project.cepat.kelar.service.common.impl;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;

import org.springframework.stereotype.Service;

import com.project.cepat.kelar.service.common.ConvertCurrencyService;

@Service
public class ConvertCurrencyServiceImpl implements ConvertCurrencyService {
	
	public static final String PATTERN2 = "Rp. #,##0;-$#,##0";

	public String convertToRupiahWithDecimal(BigDecimal curr) {

		DecimalFormat kursIndonesia = (DecimalFormat) DecimalFormat.getCurrencyInstance();
		DecimalFormatSymbols formatRp = new DecimalFormatSymbols();

		formatRp.setCurrencySymbol("Rp. ");
		formatRp.setMonetaryDecimalSeparator(',');
		formatRp.setGroupingSeparator('.');

		kursIndonesia.setDecimalFormatSymbols(formatRp);
		String currency = kursIndonesia.format(curr);

		return currency;
	}
	
	public String convertToRupiahWithoutDecimal(BigDecimal curr) {
		
		DecimalFormat kursIndonesia = (DecimalFormat) DecimalFormat.getCurrencyInstance();
		DecimalFormatSymbols formatRp = new DecimalFormatSymbols();
		
		formatRp.setCurrencySymbol("Rp. ");
		formatRp.setMonetaryDecimalSeparator(',');
		formatRp.setGroupingSeparator('.');

		kursIndonesia.setDecimalFormatSymbols(formatRp);
		String currency = kursIndonesia.format(curr);
		String numWihoutDecimal = String.valueOf(currency).split("\\,")[0];

		return numWihoutDecimal;
	}
	
	public String convertWithoutDecimal(BigDecimal curr) {
		
		DecimalFormat kursIndonesia = (DecimalFormat) DecimalFormat.getCurrencyInstance();
		DecimalFormatSymbols formatRp = new DecimalFormatSymbols();

		formatRp.setCurrencySymbol("");
		formatRp.setMonetaryDecimalSeparator(',');
		formatRp.setGroupingSeparator('.');

		kursIndonesia.setDecimalFormatSymbols(formatRp);
		String currency = kursIndonesia.format(curr);
		String numWihoutDecimal = String.valueOf(currency).split("\\,")[0];

		return numWihoutDecimal;
	}
	
}
