package com.project.cepat.kelar.common.constant;

import java.util.ArrayList;
import java.util.List;

public enum AppTimeZone {

	WIB("Waktu Indonesia Barat", "", "Asia/Jakarta", 0, "GMT+7"), 
	WITA("Waktu Indonesia Tengah", "", "Asia/Makassar", 1, "GMT+8"), 
	WIT("Waktu Indonesia Timur", "", "Asia/Jayapura", 2, "GMT+9");

	private final String labelId;
	private final String labelEn;
	private final String timeZoneId;
	private final int gmt;
	private final String labelGmt;

	private AppTimeZone(String labelId, String labelEn, String timeZoneId, int gmt, String labelGmt) {
		this.labelId = labelId;
		this.labelEn = labelEn;
		this.timeZoneId = timeZoneId;
		this.gmt = gmt;
		this.labelGmt = labelGmt;
	}

	public String getLabelId() {
		return labelId;
	}

	public String getLabelEn() {
		return labelEn;
	}

	public String getTimeZoneId() {
		return timeZoneId;
	}
	
	public int getGmt() {
		return gmt;
	}

	public String getLabelGmt() {
		return labelGmt;
	}
	
	public static List<AppTimeZone> list(){
		List<AppTimeZone> all = new ArrayList<AppTimeZone>();
		all.add(0, WIB);
		all.add(1, WITA);
		all.add(2, WIT);
		return all;
	}
}
