######Video source: https://shop119322454.taobao.com


rt=read.table("string_interactions.tsv", header=T, sep="\t", comment.char = "", check.names =FALSE)
tb=table(c(as.vector(rt[,1]),as.vector(rt[,2])))
tb=sort(tb,decreasing =T)
write.table(tb,file="count.xls",sep="\t",quote=F,col.names=F)

n=as.matrix(tb)[1:20,]   #gene number
tiff(file="barplot.tiff",width = 18,height = 15,units ="cm",compression="lzw",bg="white",res=600)
par(mar=c(2.5,6,1,2),xpd=T)
bar=barplot(n,horiz=TRUE,col="skyblue",names=FALSE,xlim=c(0,120))
text(x=n-3,y=bar,n)
text(x=-0.8,y=bar,label=names(n),xpd=T,pos=2)
dev.off()


