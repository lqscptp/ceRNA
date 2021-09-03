#install.packages("pheatmap")


library(pheatmap)          
inputFile="Heatmap.txt"      
groupFile="group.txt"  #分组文件   
outFile="heatmap.pdf"   
var="type" 
setwd("C:\\Users\\86184\\Desktop\\ceRNA0319\\42.DElncHeatmap")      #设置工作目录
rt=read.table(inputFile,header=T,sep="\t",row.names=1,check.names=F)     #读取文件
ann=read.table(groupFile,header=T,sep="\t",row.names=1,check.names=F)    #读取样本属性文�?


#绘制
pdf(file=outFile,width=5.5,height=6)

pheatmap(rt,
         annotation=ann,
         cluster_cols = F,
         color = colorRampPalette(c("blue", "white", "red"))(2000),
         show_colnames = F,
         show_rownames = F,
         gaps_row=gaps,
         scale="row",  #矫正
         border_color ="NA",
         fontsize = 8,
         fontsize_row=4,
         fontsize_col=6)
dev.off()

