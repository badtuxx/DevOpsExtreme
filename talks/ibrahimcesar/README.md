# Do Zero ao ‘Salve Mundo!’ em AWS CDK
> 2021-08-13

- [Slides PDF](./slides.pdf)
- [Slides link](https://docs.google.com/presentation/d/e/2PACX-1vQBxiBp89KqWWfvlMHoDqMjbyq638D6-rH0jYPo212N9lNh5ACo4xp380Wd1H83A6M1y-z50WBt4APx/pub)

## 🌟 [Leia o tutorial passo a passo](https://ibrahimcesar.cloud/blog/do-zero-ao-salve-mundo-em-aws-cdk-cloud-development-kit/)

Baseado no _pattern_ [Amazon API Gateway to AWS Lambda](https://serverlessland.com/patterns/apigw-lambda-cdk)

**Demo**: [https://hotjtmf4m7.execute-api.us-east-1.amazonaws.com/prod/](https://hotjtmf4m7.execute-api.us-east-1.amazonaws.com/prod/)

Note que você pode alterar o path ou testar com outros métodos (POST, etc). Por exemplo:

- [https://hotjtmf4m7.execute-api.us-east-1.amazonaws.com/prod/miliciano/](https://hotjtmf4m7.execute-api.us-east-1.amazonaws.com/prod/miliciano/)
- [https://hotjtmf4m7.execute-api.us-east-1.amazonaws.com/prod/corrupto/](https://hotjtmf4m7.execute-api.us-east-1.amazonaws.com/prod/corrupto/)

```bash
❯ curl https://hotjtmf4m7.execute-api.us-east-1.amazonaws.com/prod/genocida/
❯ Olá DevOpsExtreme, Fora Bolsonaro: "/genocida/"

❯ curl -I https://hotjtmf4m7.execute-api.us-east-1.amazonaws.com/prod/
HTTP/2 200
content-type: text/plain;charset=utf-8
content-length: 39
date: Fri, 13 Aug 2021 16:18:50 GMT
x-amzn-requestid: 5dd254ee-0262-462c-8efa-bfb1d7f4037c
x-amzn-remapped-content-length: 39
x-amz-apigw-id: EA04sGYDIAMFfQQ=
x-clacks-overhead: GNU Terry Pratchett
x-amzn-trace-id: Root=1-61169b6a-090fe42a3198fb68064c50bd;Sampled=0
x-cache: Miss from cloudfront
via: 1.1 3fff6e22f8d6795a61bfdca17d362ca5.cloudfront.net (CloudFront)
x-amz-cf-pop: GRU50-C1
x-amz-cf-id: rnncotxtTfe_-fduDwq-ZJbK71aJmp5hYFzZyISxXgYVEodddU9qzA==
```

Me segue no [twitter](https://twitter.com/ibrahimcesar)!
