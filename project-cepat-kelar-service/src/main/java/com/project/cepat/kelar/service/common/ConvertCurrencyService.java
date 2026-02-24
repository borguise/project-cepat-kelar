package com.project.cepat.kelar.service.common;

import java.math.BigDecimal;

public interface ConvertCurrencyService {

	String convertToRupiahWithDecimal(BigDecimal curr);

	String convertToRupiahWithoutDecimal(BigDecimal curr);

	String convertWithoutDecimal(BigDecimal curr);

}
