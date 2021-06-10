
fileurl='./urls.txt'
for chkurl in $(cat ${fileurl})  # ${}忽略空格
do
    # -o 输出内容到/dev/null; -s 静默方式 ；-w 定义显示输出格式；"%{http_code}" 在最后被检索的 HTTP(S) 页中被找到的数字的代码
    HTTP_CODE=`curl -o /dev/null -s --head -w "%{http_code}" "${chkurl}"`
    if [ ${HTTP_CODE} -ne 200 ]
    then
        echo -e "error-${HTTP_CODE}:" $chkurl  >>check-result.txt
    else
        echo -e ${HTTP_CODE}: $chkurl  >>check-result.txt
    fi
done
