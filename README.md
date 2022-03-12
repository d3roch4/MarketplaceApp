Este é um aplicativo de marketplace criado para o aprendizado da [Clean Architecture](https://jasontaylor.dev/clean-architecture-getting-started/). 
Tendo como objetivo final implementar os conceitos aprendidos durante os estudos teóricos e ter um código limpo que possa ser usado em uma aplicação real a ser publicada na AppleSotre ou PlayStore.
Um aplicativo de marketplace foi o escolhido pois é um ótimo objeto de estudos, ele oferece desafios ao desenvolvimento que são ótimos exemplos de aprendizagem para os padrões de projeto:
- Mediator https://refactoring.guru/design-patterns/mediator
- PubSub (Observer) https://refactoring.guru/design-patterns/observer
- Decorator https://refactoring.guru/design-patterns/decorator
- Chain of Responsibility https://refactoring.guru/design-patterns/chain-of-responsibility
- Domain Model Isolation https://enterprisecraftsmanship.com/posts/domain-model-isolation/
- CQRS https://docs.microsoft.com/en-us/azure/architecture/patterns/cqrs

A escolha de distribuição do software via loja de aplicativos é para seguir a tendência de maior utilização da internet através de dispositivos móveis. Em meus círculos sociais, eu tenho a impressão que as pessoas preferem instalar um aplicativo através da loja oficial do seu smartphone, além do mais em se tratando de comércio eletrônico é importante que as pessoas possam compartilhar links dos produtos entre si. 

Este projeto não visa implementar um marketplace completo, apenas contemplará as funcionalidades básicas para que os usuários possam realizar o fluxo completo de venda e compra de produtos.

### Backend
Para termos um desenvolvimento mais rápido será utilizado um BaaS, assim poderemos nos concentrar nas regras de negócios de nossa aplicação. Mas quais serviços iremos usar? Existe algumas alternativas no mercado, como:
- AWS Amplify
- Back4app
- Backendless
- Firebase
- ParsePlatform

Cada um desses serviços tem o seu conjunto de funcionalidades e facilitadores, tem o seu sdk, um preço e pode agradar mais a alguns e a outros não. Tá bom, mas se eu escolher o [ParsePlatform](https://parseplatform.org) e depois querer mudar pra outros?

Agora sim, vamos começar a falar do Clean Architecture, que é uma arquitetura de software que trás para o centro as camadas Domain e Aplication, essas duas camadas são o núcleo de nosso sotfware e nelas vamos implementar a lógica e tipos de negócio e de corporativa. 
No núcleo não vamos ter preocupações com banco de dados, serviços de terceiros ou apis, isso será implementado em camadas externas de modo que tais preocupações não afetem a regra de negócio do nosso software.

![Figura 1](https://i0.wp.com/jasontaylor.dev/wp-content/uploads/2020/01/Figure-01-2.png?w=531&ssl=1)

Observe na figura acima que a camada Ingrastructure está nas bordas, nessa camada que teremos acesso a serviços de backend, repositórios de dados, serviços de localização e outros. Veja também que as camadas exteriores não dependem das interiores. Se alguma coisa mudar do lado de fora, nada altera do lado de dentro.

### Pagamentos
Algo muito importante em qualquer marketplace é o pagamento, observe que teremos lógica referente a pagamento no núcleo de nosso software e também teremos acesso a processadores e gateways que estaram nas extremidades, além de poder escolher entre vários gateways como Cielo, PagSeguro, INAPay, SafraPay, podemos escolher também entre várias moedas como, dólar, real, euro, bitcoins Ethereum sem precisar alterarmos o código do núcleo.

### Ui
A camada de interface com usuário também estará as bordas, podemos escolher entre diversos frameworks, estilos, animações, tipos de tela ou até mesmo via linha de comando sem afetar as regras de negócio da nossa aplicação. 
Como esse aplicativo será distribuido na PlayStore e AppleStore será utilizado o framework Flutter que além de compilar para iOS, Android, Desktop, também gera para Web em PWA assim as pessoas que receberem o link dos produtos a venda possam visualizar e até efetivar a compra sem precisar instalar antes.

## Estrutura do projeto
Segue alguns vídeos explicando a estrutura do projeto:
  1. https://www.loom.com/share/c5238a2a9b2d423f83c1bef3c84bd731
  2. https://www.loom.com/share/d61d3a2c504f4740ab5a71bbdafb326d
  3. https://www.loom.com/share/28b693212e834feb8444f30b6c649a13
