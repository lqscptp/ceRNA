#install.packages('survival')
#install.packages('survminer')


#引用包
library(survival)
library(survminer)
kmPfilter=0.05             #KM方法显著性过滤标准
inputFile="lncRNAExpExpTime.txt"     #输入文件名称
setwd("C:\\Users\\lexb4\\Desktop\\immCeRNA\\16.geneSurvival")            #设置工作目录
rt=read.table(inputFile,header=T,sep="\t",check.names=F,row.names=1)     #读取输入文件
rt$futime=rt$futime/365

outTab=data.frame()
for(i in colnames(rt[,3:ncol(rt)])){
	if(sd(rt[,i])<0.001){next}
	#KM分析
	group=ifelse(rt[,i]>median(rt[,i]),"high","low")
	diff=survdiff(Surv(futime, fustat) ~group,data = rt)
	pValue=1-pchisq(diff$chisq,df=1)

	#对p<0.05的基因绘制生存曲线
	if(pValue<kmPfilter){
		outVector=cbind(i,pValue)
		outTab=rbind(outTab,outVector)
		#绘制生存曲线	    
		if(pValue<0.001){pValue="p<0.001"
		}else{pValue=paste0("p=",sprintf("%.03f",pValue))
		}
		fit <- survfit(Surv(futime, fustat) ~ group, data = rt)
		surPlot=ggsurvplot(fit, 
				           data=rt,
				           pval=pValue,
				           conf.int=T,
				           pval.size=5,
				           risk.table=TRUE,
				           legend.labs=c("High", "Low"),
				           legend.title=i,
				           xlab="Time(years)",
				           break.time.by = 1,
				           risk.table.title="",
				           palette=c("red", "blue"),
				           risk.table.height=.25)
		pdf(file=paste0("sur.",i,".pdf"),onefile = FALSE,width = 6.5,height =5.5)
		print(surPlot)
		dev.off()
	}
}
#输出基因和p值表格文件
write.table(outTab,file="geneSur.result.xls",sep="\t",row.names=F,quote=F)


