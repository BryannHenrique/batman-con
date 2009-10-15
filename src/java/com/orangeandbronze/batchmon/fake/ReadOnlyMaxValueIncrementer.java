package com.orangeandbronze.batchmon.fake;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.support.incrementer.DataFieldMaxValueIncrementer;

public class ReadOnlyMaxValueIncrementer implements
		DataFieldMaxValueIncrementer {

	public int nextIntValue() throws DataAccessException {
		
		return 0;
	}

	public long nextLongValue() throws DataAccessException {
		
		return 0L;
	}

	public String nextStringValue() throws DataAccessException {
		return "";
	}

}
