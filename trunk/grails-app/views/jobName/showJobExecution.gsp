<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Show Job Instance</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${resource(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="index">Batch Jobs</g:link></span>
        </div>       
        <div class="body">
            <h1>Batch Execution Instance</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>                    
                        <tr class="prop">
                            <td valign="top" class="name">Id:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:jobExecution, field:'id')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Job Instance:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:jobInstance, field:'id')}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Create Time:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:jobExecution, field:'createTime')}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Start Time:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:jobExecution, field:'startTime')}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">End Time:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:jobExecution, field:'endTime')}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Status:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:jobExecution, field:'status')}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Last Updated:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:jobExecution, field:'lastUpdated')}</td>
                            
                        </tr>
					</tbody>
                </table>
            </div>
            <h1>Batch Execution Steps</h1>
	        <g:set var="stepExecutions" value="${jobExecution.stepExecutions}" />            
            <div class="list">
                <table>
                    <thead>
                        <tr>
                            <g:sortableColumn property="stepName" title="${message(code: 'stepExecution.stepName.label', default: 'Name')}" />
                            <g:sortableColumn property="status" title="${message(code: 'stepExecution.status.label', default: 'Status')}" />
                            <g:sortableColumn property="startTime" title="${message(code: 'stepExecution.startTime.label', default: 'Start Time')}" />
                            <g:sortableColumn property="endTime" title="${message(code: 'stepExecution.endTime.label', default: 'End Time')}" />
                            <g:sortableColumn property="lastUpdated" title="${message(code: 'stepExecution.lastUpdated.label', default: 'Last Update')}" />
                            <g:sortableColumn property="readCount" title="${message(code: 'stepExecution.readCount.label', default: 'Read Count')}" />
                            <g:sortableColumn property="writeCount" title="${message(code: 'stepExecution.writeCount.label', default: 'Write Count')}" />
                            <g:sortableColumn property="commitCount" title="${message(code: 'stepExecution.commitCount.label', default: 'Commit Count')}" />
                            <g:sortableColumn property="rollbackCount" title="${message(code: 'stepExecution.rollbackCount.label', default: 'Rollback Count')}" />
                            <g:sortableColumn property="readSkipCount" title="${message(code: 'stepExecution.readSkipCount.label', default: 'Read Skip Count')}" />
                            <g:sortableColumn property="processSkipCount" title="${message(code: 'stepExecution.processSkipCount.label', default: 'Process Skip Count')}" />
                            <g:sortableColumn property="writeSkipCount" title="${message(code: 'stepExecution.writeSkipCount.label', default: 'Write Skip Count')}" />
                            <g:sortableColumn property="filterCount" title="${message(code: 'stepExecution.filterCount.label', default: 'Filter Count')}" />
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${stepExecutions}" status="i" var="stepExecution">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td>${fieldValue(bean:stepExecution, field:'stepName')}</td>             
                            <td>${fieldValue(bean:stepExecution, field:'status')}</td>             
                            <td>${fieldValue(bean:stepExecution, field:'startTime')}</td>             
                            <td>${fieldValue(bean:stepExecution, field:'endTime')}</td>             
                            <td>${fieldValue(bean:stepExecution, field:'lastUpdated')}</td>             
                            <td>${fieldValue(bean:stepExecution, field:'readCount')}</td>             
                            <td>${fieldValue(bean:stepExecution, field:'writeCount')}</td>             
                            <td>${fieldValue(bean:stepExecution, field:'commitCount')}</td>             
                            <td>${fieldValue(bean:stepExecution, field:'rollbackCount')}</td>             
                            <td>${fieldValue(bean:stepExecution, field:'readSkipCount')}</td>             
                            <td>${fieldValue(bean:stepExecution, field:'processSkipCount')}</td>             
                            <td>${fieldValue(bean:stepExecution, field:'writeSkipCount')}</td>             
                            <td>${fieldValue(bean:stepExecution, field:'filterCount')}</td>             
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
          
        </div>
    </body>
</html>
