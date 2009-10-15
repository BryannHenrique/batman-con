package com.orangeandbronze.batchmon

import org.springframework.batch.core.JobExecution;
import org.springframework.batch.core.JobInstance;

class JobInstanceService {
	
	def jobInstanceDao
	def jobExecutionDao
	def stepExecutionDao
	
    boolean transactional = false

    def getJobNames() {
		return jobInstanceDao.getJobNames()
    }
	def getJobInstances(String jobName, int start, int count) {
		return jobInstanceDao.getJobInstances(jobName, start, count)
	}
	def getJobInstance(Long id) {
		return jobInstanceDao.getJobInstance(id)
	}
	def findJobExecutions(JobInstance jobInstance) {
		def jobExecutions = jobExecutionDao.findJobExecutions(jobInstance)
		jobExecutions.each {
			stepExecutionDao.addStepExecutions(it)
		}
		return jobExecutions
	}
	def findJobExecutions(Long jobInstanceId) {
		def jobInstance = getJobInstance(jobInstanceId)
		return findJobExecutions(jobInstance)
	}
	def findRunningJobExecutions(String jobName) {
		def jobExecutions = jobExecutionDao.findRunningJobExecutions(jobName)
		jobExecutions.each { jobExecution ->
			def jobInstance = jobInstanceDao.getJobInstance(jobExecution)
			jobExecution.setJobInstance(jobInstance)
			stepExecutionDao.addStepExecutions(jobExecution)
		}
		return jobExecutions
	}
	def getJobExecution(Long id) {
		def jobExecution = jobExecutionDao.getJobExecution(id)
		def jobInstance = jobInstanceDao.getJobInstance(jobExecution)
		jobExecution.setJobInstance(jobInstance)
		stepExecutionDao.addStepExecutions(jobExecution)
		return jobExecution
	}
}
