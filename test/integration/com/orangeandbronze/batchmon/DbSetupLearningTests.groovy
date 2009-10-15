package com.orangeandbronze.batchmon

import grails.test.*

class DbSetupLearningTests extends GrailsUnitTestCase {
	def dataSource
	def jobInstanceDao
	def jobExecutionDao
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testDataSourceSetup() {
    	assertNotNull dataSource
    }
    void testDataSourceClass() {
    	assertEquals "class org.apache.commons.dbcp.BasicDataSource", dataSource.getClass().toString()
    }
    void testJobInstanceDaoSetup() {
    	assertNotNull jobInstanceDao
    }
    void testJobExecutionDaoSetup() {
    	assertNotNull jobExecutionDao
    }
}
