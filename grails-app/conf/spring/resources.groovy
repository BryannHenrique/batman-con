
beans = {
		jobInstanceDao(org.springframework.batch.core.repository.dao.JdbcJobInstanceDao) {
			jdbcTemplate = ref("jdbcTemplate")
			jobIncrementer = ref("jobIncrementer")
		}
		jdbcTemplate(org.springframework.jdbc.core.simple.SimpleJdbcTemplate, ref("dataSource")) {}
		jobIncrementer(com.orangeandbronze.batchmon.fake.ReadOnlyMaxValueIncrementer) {}
		jobExecutionDao(org.springframework.batch.core.repository.dao.JdbcJobExecutionDao) {
			jdbcTemplate = ref("jdbcTemplate")
			jobExecutionIncrementer = ref("jobExecutionIncrementer")
		}
		jobExecutionIncrementer(com.orangeandbronze.batchmon.fake.ReadOnlyMaxValueIncrementer) {}
		stepExecutionDao(org.springframework.batch.core.repository.dao.JdbcStepExecutionDao) {
			jdbcTemplate = ref("jdbcTemplate")
			stepExecutionIncrementer = ref("stepExecutionIncrementer")
		}
		stepExecutionIncrementer(com.orangeandbronze.batchmon.fake.ReadOnlyMaxValueIncrementer) {}
}