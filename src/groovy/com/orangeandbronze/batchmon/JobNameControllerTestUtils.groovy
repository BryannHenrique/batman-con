
package com.orangeandbronze.batchmon

import grails.test.ControllerUnitTestCase

public class JobNameControllerTestUtils {
    static checkIndexModel = { expectedResult, model ->
	    ControllerUnitTestCase.assertEquals expectedResult.size(), model.jobNamesTotal
	    checkExpectedList(expectedResult, model.jobNames)
    }
    static checkExpectedList(expectedResult, actual) {
	    ControllerUnitTestCase.assertEquals expectedResult.size(), actual.size()
		expectedResult.eachWithIndex { item, index ->
			ControllerUnitTestCase.assertEquals item, actual[index]
		}    	
    }
}