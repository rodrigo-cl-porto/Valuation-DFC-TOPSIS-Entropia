# AVALIAÇÃO DE SOCIEDADES ANÔNIMAS BRASILEIRAS: Uma proposta de _valuation_ com Fluxo de Caixa Descontado e ordenação por TOPSIS
Trabalho de Conclusão de Curso apresentado ao Corpo Docente do Departamento de Engenharia de Produção da Escola de Engenharia da Universidade Federal Fluminense, como parte dos requisitos necessários à obtenção do título de Engenheiro de Produção.

- **UNIVERSIDADE FEDERAL FLUMINENSE**
- **ESCOLA DE ENGENHARIA**
- **Autor**: Rodrigo Celso de Lima Porto
- **Orientador**: Prof. Dr. Gilson Brito Alves Lima
- **Coorientador**: Prof. Dr. Ricardo Bordeaux Rego
- Aprovado em 25 de junho de 2024
- Niterói - RJ

## RESUMO
Este trabalho tem como objetivo apresentar um método automatizado para avaliar empresas brasileiras listadas na B3 com base na análise de seus balanços patrimoniais, demonstrações de resultados e demonstrações de fluxo de caixa. O processo de avaliação é dividido em duas etapas. Primeiramente, adota-se uma abordagem intrínseca, utilizando o método de Fluxo de Caixa Descontado (FCD) para calcular o valor intrínseco inicial das ações. Em seguida, recorre-se a uma abordagem comparativa, na qual empresas pertencentes ao mesmo setor são ordenadas através do método multicritério TOPSIS, utilizando indicadores fundamentalistas como critérios do modelo. O TOPSIS, por sua vez, determina um coeficiente de similaridade para cada empresa, que serve como subsídio para o cálculo do prêmio ou desconto em relação ao valor intrínseco original. Esse cálculo resulta no valor intrínseco ajustado, que por sua vez é utilizado para estimar o potencial de valorização ou desvalorização das ações, também conhecido por margem de segurança, a qual será usada para selecionar as ações com as maiores margens em cada setor para compor a carteira a ser performada no ano. Após simular a performance das carteiras selecionadas pelo método proposto, para o período de 2016 a 2023, observou-se que elas rentabilizaram mais do que o índice de mercado brasileiro, o Ibovespa.

**Palavras-chave**: Valuation, Fluxo de Caixa Descontado, TOPSIS, ETL.

## LISTA DE ABREVIATURAS E SIGLAS

- <span id="ahp">**AHP**</span>: *Analytic Hierarchy Process* (Processo de Hierarquia Analítica)
- <span id="b3">**B3**</span>: Brasil, Bolsa e Balcão
- <span id="bp">**BP**</span>: Balanço Patrimonial
- <span id="capm">**CAPM**</span>: *Capital Asset Pricing Model* (Modelo de Precificação de Ativos Financeiros)
- <span id="capex">**CAPEX**</span>: *Capital Expenditures* (Investimentos em Capital)
- <span id="cc">**CC**</span>: *Closeness Coeficient* (Coeficiente de Similaridade)
- <span id="cmpc">**CMPC**</span>: Custo Médio Ponderado de Capital
- <span id="cofins">**COFINS**</span>: Contribuição para o Financiamento da Seguridade Social
- <span id="crisp-dm">**CRISP-DM**</span>: *Cross Industry Standard Process for Data Mining* (Processo Padrão Interindústrias para Mineração de Dados)
- <span id="cssl">**CSSL**</span>: Contribuição Social Sobre o Lucro
- <span id="cvm">**CVM**</span>: Comissão de Valores Mobiliários
- <span id="dfc">**DFC**</span>: Demonstrativo de Fluxo de Caixa
- <span id="dl-pl">**DL/PL**</span>: Dívida Líquida sobre Patrimômio Líquido
- <span id="dre">**DRE**</span>: Demonstrativo de Resultado do Exercício
- <span id="dy">**DY**</span>: *Dividend Yield* (Rendimento de Dividendos)
- <span id="ebit">**EBIT**</span>: *Earnings Before Interests and Taxes* (Lucro Antes de Juros e Impostos)
- <span id="ebitda">**EBITDA**</span>: *Earnings Before Interests, Taxes, Depreciation and Amortization* (Lucro Antes de Juros, Impostos, Depreciações e Amortizações)
- <span id="esg">**ESG**</span>: *Environmental, Social & Governance* (Meio Ambiente, Social e Governança Corporativa)
- <span id="etl">**ETL**</span>: *Extract, Transform & Load* (Extração, Transformação e Carregamento)
- <span id="eua">**EUA**</span>: Estados Unidos da América
- <span id="fcd">**FCD**</span>: Fluxo de Caixa Descontado
- <span id="fcf">**FCF**</span>: Fluxo de Caixa dos Financiamentos
- <span id="fcfe">**FCFE**</span>: *Free Cash Flow to Equity* (Fluxo de Caixa Livre para os Acionistas)
- <span id="fcff">**FCFF**</span>: *Free Cash Flow to Firm* (Fluxo de Caixa Livre para a Empresa)
- <span id="fci">**FCI**</span>: Fluxo de Caixa dos Investimentos
- <span id="fco">**FCO**</span>: Fluxo de Caixa Operacional
- <span id="fre">**FRE**</span>: Formulário de Referência
- <span id="hme">**HME**</span>: Hipótese do Mercado Eficiente
- <span id="ibra">**IBrA**</span>: Índice Brasil Amplo
- <span id="icms">**ICMS**</span>: Imposto sobre Circulação de Mercadorias e Serviços
- <span id="ir">**IR**</span>: Imposto de Renda
- <span id="iot">**IoT**</span>: *Internet of Things* (Internet das Coisas)
- <span id="lair">**LAIR**</span>: Lucro Antes do Imposto de Renda
- <span id="ll">**LL**</span>: Lucro Líquido
- <span id="mcdm">**MCDM**</span>: *Multi-Criteria Decision-Making* (Método de Apoio à Decisão Multicritério)
- <span id="mpe">**MPE**</span>: Micro e Pequenas Empresas
- <span id="ms">**MS**</span>: Margem de Segurança
- <span id="nasdaq">**NASDAQ**</span>: *National Association of Securities Dealers Automated Quotations* (Cotações Automatizadas da Associação Nacional de Corretores de Valores Mobiliários)
- <span id="nis">**NIS**</span>: *Negative Ideal Solution* (Solução Ideal Negativa)
- <span id="nopat">**NOPAT**</span>: *Net Operating Profit After Tax* (Lucro Operacional Líquido Após Impostos)
- <span id="nyse">**NYSE**</span>: *New York Stock Exchange* (Bolsa de Valores de Nova York)
- <span id="pg">**PG**</span>: Progressão Geométrica
- <span id="pib">**PIB**</span>: Produto Interno Bruto
- <span id="pis1">**PIS**</span>: Programa de Integração Social
- <span id="pis2">**PIS**</span>: *Positive Ideal Solution* (Solução Ideal Positiva)
- <span id="pl">**PL**</span>: Patrimônio Líquido
- <span id="p-l">**P/L**</span>: Preço por Ação sobre Lucro por Ação
- <span id="p-vp">**P/VP**</span>: Preço por Ação sobre Valor Patrimonial por Ação
- <span id="rl">**RL**</span>: Receita Líquida
- <span id="roa">**ROA**</span>: *Return On Asset* (Retorno Sobre o Ativo)
- <span id="roe">**ROE**</span>: *Return On Equity* (Retorno Sobre o Patrimônio Líquido)
- <span id="selic">**Selic**</span>: Sistema Especial de Liquidação e Custódia
- <span id="topsis">**TOPSIS**</span>: *Technique for Order of Preference by Similarity to Ideal Solution* (Técnica para Ordem de Preferência por Similaridade com a Solução Ideal)
- <span id="wacc">**WACC**</span>: *Weighted Average Cost of Capital* (Custo Médio Ponderado de Capital)

## DEDICATÓRIA

À minha família, que me deu o apoio necessário para tornar este trabalho realidade.

## AGRADECIMENTOS

Agradeço, primeiramente, aos meus pais, que depositaram todos os seus esforços em mim, sem os quais não conseguiria ter chegado tão longe.

Agradeço ao Prof. Gilson Lima pela sua orientação com este trabalho e pelos insights sobre a sua elaboração. Também agradeço ao Prof. Ricardo Bordeaux pela sua orientação, pela sua disponibilidade para tirar minhas dúvidas e pelas recomendações bibliográficas sobre finanças e avaliação de econômica de empresas, os quais foram úteis para o desenvolvimento deste trabalho.

Agradeço também aos vários colegas e ao restante dos professores com quem me encontrei ao longo da minha jornada acadêmica na UFF

## EPÍGRAFE

> _O sucesso em investimentos decorre não de acertar sempre, mas de errar com menos frequência do que os outros._

_Aswath Damodaran_

## LISTA DE FIGURAS

1. [Figura 1 – Fases do modelo CRISP-DM](#figure1)
1. [Figura 2 – Tripé do investidor](#figure2)
1. [Figura 3 – Fluxograma ETL da proposta de _valuation_](#figure3)

## LISTA DE GRÁFICOS

1. [Gráfico 1 – Rentabilidades reais dos ativos no mercado dos EUA,1802-2012](#graphic1)
1. [Gráfico 2 – Retornos reais máximos e mínimos das ações, renda fixa e tesouro ao longo dos anos](#graphic2)
1. [Gráfico 3 – Desvio padrão dos retornos reais médios das ações, dos títulos de longo prazo e das letras em vários horizontes de investimento: dados históricos e hipótese do passeio aleatório, 1802-2012](#graphic3)
1. [Gráfico 4 – Retornos das Carteiras Selecionadas vs Retornos do Ibovespa](#graphic4)
1. [Gráfico 5 – Retornos dos modelos vs Retornos do Ibovespa](#graphic5)

## LISTA DE TABELAS

1. [Tabela 1 – Modelo de Balanço Patrimonial](#table1)
1. [Tabela 2 – Modelo de DRE](#table2)
1. [Tabela 3 – Modelo de DFC](#table3)
1. [Tabela 4 – Cálculo do FCFE](#table4)
1. [Tabela 5 – Objetivos e valores do investidor conservador](#table5)
1. [Tabela 6 – Conjunto de dados utilizados](#table6)
1. [Tabela 7 – Indicadores fundamentalistas utilizadas no TOPSIS](#table7)
1. [Tabela 8 – Definição por parte da função](#table8)
1. [Tabela 9 – Carteiras Selecionadas (2016 - 2023)](#table9)
1. [Tabela 10 – Retornos das carteiras dos modelos de backtest](#table10)

## Sumário

1. [INTRODUÇÃO](#introdução)
    1. [OBJETIVOS](#objetivos)
        1. [Objetivo Geral](#objetivo-geral)
        1. [Objetivos Específicos](#objetivos-específicos)
    1. [Delimitações do estudo](#delimitações-do-estudo)
    1. [Estruturação do estudo](#estruturação-do-estudo)
1. [REFERENCIAL TEÓRICO](#referencial-teórico)
    1. [DEMONSTRAÇÕES CONTÁBEIS](#demonstrações-contábeis)
        1. [Balanço Patrimonial (BP)](#balanço-patrimonial-bp)
        1. [Demonstração de Resultado de Exercício (DRE)](#demonstração-de-resultado-de-exercício-dre)
        1. [Demonstração de Fluxo de Caixa (DFC)](#demonstração-de-fluxo-de-caixa-dfc)
    1. [VALUATION](#valuation)
        1. [Fluxo de Caixa Descontado (FCD)](#fluxo-de-caixa-descontado-fcd)
        1. [Avaliação Comparativa](#avaliação-comparativa)
        1. [Apoio Multicritério para Tomada de Decisão (DCMD)](#apoio-multicritério-para-tomada-de-decisão-dcmd)
        1. [Power Query](#power-query)
1. [METODOLOGIA](#metodologia)
    1. [COMPREENSÃO DO NEGÓCIO](#compreensão-do-negócio)
    1. [COMPREENSÃO DOS DADOS](#compreensão-dos-dados)
    1. [PREPARAÇÃO DOS DADOS](#preparação-dos-dados)
    1. [MODELAGEM](#modelagem)
    1. [AVALIAÇÃO](#avaliação)
    1. [IMPLANTAÇÃO](#implantação)
1. [ANÁLISE E DISCUSSÃO DOS RESULTADOS](#análise-e-discussão-dos-resultados)
1. [CONCLUSÕES](#conclusões)
1. [REFERÊNCIAS](#referências)

# **INTRODUÇÃO**

Avaliar com precisão o valor justo de um ativo é uma tarefa imprescindível para os analistas, investidores, administradores e gestores de empresas e instituições financeiras. Tomar decisões acertadas sobre a alocação de recursos é crucial, pois isso representa um potencial significativo para o crescimento dos investimentos. Isso se traduz em benefícios tanto para as empresas e instituições, que podem obter mais capital próprio para financiar a implementação de seus planos estratégicos, por meio de CAPEX, programas, projetos etc., quanto para o investidor individual, que pode acelerar a acumulação do patrimônio necessário para gerar a renda passiva que cubra seu custo de vida, alcançando, assim, a almejada independência financeira.

Dentre os ativos negociados no mercado financeiro, as ações são os que possuem o maior potencial de valorização no longo prazo, como apontado por Siegel (2015). Ele analisou a rentabilidade real das principais aplicações financeiras estadunidenses ao longo dos últimos 210 anos, verificando o quanto o investimento de US$ 1,00 em 1802, em cada um dos principais conjuntos de ativos do mercado, valeria em 2012.

|<span id="graphic1">Gráfico 1</span> – Rentabilidades reais dos ativos no mercado dos EUA, em escala logarítmica, 1802-2012|
|:---:|
|![Gráfico 1](https://cdn.jsdelivr.net/gh/rodrigo-cl-porto/Valuation-DFC-TOPSIS-Entropia/docs/assets/graphic1.png)|
|Fonte: Siegel (2015)|

O [Gráfico 1](#graphic1) apresenta, em escala logarítmica, a rentabilidade do conjunto de ativos considerados no estudo de Siegel (2015) e evidencia que as ações auferiram o maior retorno do período, superando notoriamente o crescimento dos outros ativos. Enquanto US$ 1,00 investido em ações em 1802 teria rentabilizado mais de US$ 700 mil, com crescimento médio anual de 6,6% acima da inflação, a segunda maior rentabilidade real seria a da renda fixa, em que US$ 1,00 em 1802 teriam auferido apenas quase US$ 1,8 mil de lucro ao longo de mais de dois séculos, a uma média de 3,6% ao ano. Outro ponto interessante é que a rentabilidade das ações, na escala logarítmica, segue uma notória tendência linear crescente, enquanto no restante dos ativos, tal tendência não foi claramente observada.

Além disso, ainda segundo Siegel (2015, p. 66), as ações são os ativos que apresentam menores riscos para a carteira no longo prazo. O [Gráfico 2](#graphic2) mostra os retornos máximos e mínimos das ações comparadas com os da renda fixa e títulos do Tesouro dos EUA, considerados os mais conservadores. Ao interpretar que o retorno máximo é uma medida de rentabilidade, enquanto o mínimo é uma medida de risco, então se constata que, nos primeiros cinco anos, as ações são mais rentáveis, porém são mais arriscadas que a renda fixa e o Tesouro, indo ao encontro do consenso. Porém, após esse período, elas apresentam em média um retorno mínimo maior do que os outros dois. E após duas décadas, apresenta um retorno mínimo positivo, enquanto os outros dois tipos conservadores permanecem com retorno mínimo negativo.

|<span id="graphic2">Gráfico 2</span> – Retornos reais máximos e mínimos das ações, renda fixa e tesouro ao longo dos anos|
|:---:|
|![Gráfico 2](https://cdn.jsdelivr.net/gh/rodrigo-cl-porto/Valuation-DFC-TOPSIS-Entropia/docs/assets/graphic2.png)|
|Fonte: Siegel (2015)|

Além disso, ao definir que o risco de um ativo pode ser determinado pelo seu desvio-padrão dos retornos reais anuais médios sua série histórica, é possível ver pelo [Gráfico 3](#graphic3) que o desvio padrão do retorno acionário supera o dos títulos públicos e de renda fixa na primeira década. Entretando, o risco acionário se torna menor do que os outros dois após esse período, não condizendo com o risco estimado pela hipótese do passeio aleatório (SIEGEL, 2015).

|<span id="graphic3">Gráfico 3</span> – Desvio padrão dos retornos reais médios das ações, dos títulos de longo prazo e das letras em vários horizontes de investimento: dados históricos e hipótese do passeio aleatório, 1802-2012|
|:---:|
|![Gráfico 3](https://cdn.jsdelivr.net/gh/rodrigo-cl-porto/Valuation-DFC-TOPSIS-Entropia/docs/assets/graphic3.png)|
|Fonte: Siegel (2015)|

Siegel (2015) alerta que, pelo [Gráfico 3](https://cdn.jsdelivr.net/gh/rodrigo-cl-porto/Valuation-DFC-TOPSIS-Entropia/docs/assets/graphic3.png), não está afirmando que o risco das ações diminui à medida que o tempo passa. Na verdade, o que ocorre é que o desvio padrão dos retornos totais das ações aumenta com o tempo, porém a um ritmo progressivamente mais lento do que o dos títulos ou da renda fixa. Isso é atribuído à incerteza quanto à inflação, a qual leva a um rápido aumento da volatilidade dos ativos mais conservadores à medida que o período se estende (SIEGEL, 2015).

Assim, fica evidente que as ações são as mais ideais para investimentos de longo prazo. Não obstante, tal conclusão não pode ser estendida para o mercado brasileiro, uma vez que não se tem registro de dados financeiros com intervalo de tempo tão longo quanto o dos EUA. Porém, trabalhos de Borfe e Schwerz (2018), Duarte (2019), Hendges e Rodrigues (2021) e Bainha e Sodré (2022) dão ao menos alguns leves indícios de que as rentabilidades das ações brasileiras superaram as da renda fixa ou que foram menos voláteis que a renda fixa em certos períodos.

Outra distinção fundamental entre o mercado financeiro dos [EUA](#eua) e o do Brasil é a diferença de escala. Enquanto a capitalização de mercado da [B3](#b3) gira em torno de US$ 791 bilhões, as duas principais bolsas de valores do mundo, [NYSE](#nyse) e [Nasdaq](#nasdaq), apresentam uma capitalização de US$ 22,7 trilhões e US$ 18 trilhões, respectivamente (TORO, 2023). Isso equivale a quase 29 vezes e 23 vezes a capitalização da B3. Além disso, o número de investidores no Brasil é consideravelmente limitado, totalizando apenas 17,3 milhões, dos quais cerca de 5 milhões investem em renda variável, ou seja, apenas um pouco mais de 2% da sua população (B3, 2022).

O contexto apresentado sugere que as premissas da [HME](#hme), formulada por Fama (1970), não se aplicariam adequadamente ao mercado financeiro brasileiro. De acordo com essa hipótese, em um mercado eficiente, é improvável que haja uma discrepância significativa entre o preço negociado dos ativos e seu valor justo (_fair value_), uma vez que existe uma ampla cobertura por analistas financeiros em todo o mundo, acompanhando consistentemente as informações referentes a esses ativos em tempo real. Além disso, todos os participantes teriam igual acesso a informações relevantes sobre a qualidade desses ativos, resultando em um consenso em relação ao valor mais apropriado para cada um deles.

Fama (1970) ainda detalha três formas de eficiência de mercado: (1) a eficiência fraca, onde não é possível que um investidor consiga uma performance acima da média do mercado a partir de inferências de preços antigos; (2) a semiforte, em que não é possível ao investidor superar o mercado nem com dados históricos ou públicos; (3) a forma forte, em que nem mesmo informações privadas (privilegiadas) representariam uma vantagem, pois todos os tipos de informações já estariam refletidas nos preços.

Trabalhos realizados por Camargos e Barbosa (2006, 2015) e Forti, Peixoto e Santiago (2009) revelam que o mercado brasileiro não é tão eficiente quanto a forma semiforte definida pela HME, o que revela possíveis oportunidades de ações sendo precificadas bem além ou aquém do seu valor intrínseco na B3, devido ao seu ajuste lento e gradual dos preços após a publicação de fatos relevantes, como fusões e aquisições, por exemplo.

Por isso, é imprescindível que análises de _valuation_ das empresas sejam realizados para o mercado brasileiro, por meio da análise dos demonstrativos contábeis, como Balanços Patrimoniais (BP), Demonstrações de Resultado de Exercício (DRE), Demonstrações de Fluxo de Caixa (DFC) etc., para o cálculo de seus indicadores fundamentalistas. Segundo Damodaran (2012), os vários tipos de modelos existentes de _valuation_ podem ser resumidos em duas abordagens: intrínseca e comparativa. Na avaliação intrínseca, o valor de um ativo é determinado pela expectativa dos seus fluxos de caixa futuros, gerados ao longo de sua vida útil. O modelo de avaliação intrínseca mais empregado é o de Fluxo de Caixa Descontado (FCD), que traz os fluxos futuros para o seu valor presente por meio da aplicação de uma taxa de desconto. Já na avaliação comparativa (ou relativa), define-se o valor de um ativo comparando-o com outros ativos semelhantes, geralmente feito por meio da comparação de indicadores fundamentalistas, como P/L, P/VP, ROE, Margem Líquida etc. No entanto, como o próprio Damodaran (2012) explica, as duas abordagens não são mutuamente excludentes, não impedindo de haver avaliações que apliquem ambas.

Dado isso, este estudo visa apresentar um modelo de avaliação que combina as duas abordagens: uma primeira avaliação intrínseca, utilizando o método FCD, seguida de uma avaliação comparativa empregada pelo método multicritério de apoio à decisão (MCDM) TOPSIS. O TOPSIS compara cada alternativa de uma matriz de decisão com as soluções ideais (PIS) e anti-ideais (NIS), calculando um coeficiente de similaridade (CC) para cada uma delas, e as ordena segundo esse valor, em ordem decrescente. O intuito é usar esse coeficiente para ajustar o valor intrínseco calculado pelo FCD a fim de obter o resultado definitivo da avaliação, algo que é chamado por Damodaran (2012) de _polimento pós-avaliação_.

Essa proposta de _valuation_ é inspirada no trabalho realizado por Lima et al. (2010), onde os autores aplicaram o modelo de FCD para calcular o valor intrínseco de três MPEs, dos setores químico, farmacêutico e de turismo. Posteriormente, esse valor foi ajustado (polido) com base nos resultados obtidos por um método MCDM, conduzido pelo software Macbeth.

A principal distinção deste estudo em relação ao trabalho de Lima et al. (2010) reside na proposta de um modelo automatizado de avaliação, por meio de um processo de Extração, Transformação e Carregamento ([ETL](#etl)) de dados financeiros de todas as empresas listadas na [B3](#b3). A partir desses dados, os valores intrínsecos das ações serão inicialmente estimados pelo FCD para, posteriormente, serem ajustados pelo coeficiente de similaridade calculado pelo TOPSIS.

Desse modo, o estudo busca introduzir um método abrangente que leve em consideração tanto os fatores internos quanto externos para estimar o valor das empresas. Isso é alcançado não somente por meio da análise dos aspectos financeiros internos, mas também através da comparação da empresa com outras entidades do mesmo setor.

## **OBJETIVOS**

A seguir, são apresentados os objetivos deste trabalho, os quais têm como propósito responder a seguinte questão: “Dado a ineficiência existente no mercado financeiro brasileiro, é possível criar uma carteira de ações com performance superior e consistente no mercado acionário, ao avaliar os seus potenciais de valorização por meio da aplicação de um método que considere não só o seus valores intrínsecos, mas também os seus valores relativos às outras empresas pela comparação de indicadores fundamentalistas por meio de um MCDM?”.

### **Objetivo Geral**

O objetivo geral será criar um processo automatizado de _valuation_ que busca construir uma carteira de ações a partir do seu potencial de valorização, calculado por um método de _valuation_ que considere tanto as abordagens intríseca e comparativa.

Para alcançar esse objetivo, um processo ETL de dados financeiros das empresas listadas na B3 será escrito em um script em código Mashup (M Code), linguagem de consulta nativa do Power Query.

### **Objetivos Específicos**

a. Estudar as principais referências disponíveis sobre _valuation_, com o intuito de verificar quais os melhores métodos para serem aplicados para o mercado brasileiro, quais os índices de referência a serem considerados e quais as premissas mais adequadas para o modelo adotado.

a. Estudar o valor intrínseco das empresas a partir dos documentos e relatórios publicados na CVM, tais como BPs, DREs e DFCs.

a. Verificar o valor relativo das empresas de um mesmo setor a partir de um método multicritério de apoio à decisão, comparando as empresas por meio de indicadores fundamentalistas.

## **DELIMITAÇÕES DO ESTUDO**

Para a composição de uma carteira de um determinado ano, o estudo delimitar-se-á na aplicação de um método de avaliação intrínseca seguida de um ajuste por meio da avaliação comparativa. A avaliação intrínseca limitar-se-á na análise financeira e operacional dos dados públicos das empresas de capital aberto na B3 ao longo dos últimos 5 anos a partir de uma data de referência, com cálculo para projeções dos seus fluxos de caixa para os próximos 3 anos.

A avaliação comparativa, por sua vez, limitar-se-á na análise dos indicadores fundamentalistas das empresas no ano de referência, calculados a partir das informações extraídas de seus demonstrativos contábeis, das cotações históricas e da distribuição de dividendos (estas duas últimas extraídas do Yahoo! Finance).

Para a realização dos _backtests_, pegou-se o maior período histórico disponível que dava para extrair dos dados disponíveis pela CVM e pela estruturação das avaliações, de 2016 a 2023.

## **ESTRUTURAÇÃO DO ESTUDO**

O presente trabalho foi estruturado em cinco seções: introdução, referencial teórico, metodologia, discussão dos resultados e conclusão.

A introdução serviu para explicar a importância de realizar a análise de ações no contexto brasileiro, justificar a motivação de propor o método de _valuation_ a ser apresentado e delinear os principais objetivos a ser alcançado neste estudo.

O referencial teórico visa explanar sobre o arsenal teórico proveniente das áreas de finanças corporativas, avaliação de investimentos e MCDM, a fim de que o leitor acompanhe e entenda a linha de raciocínio traçada para a confecção do método proposto.

A terceira seção foi reservada para explicar sobre o CRISP-DM, proposta por Chapman et al. (2000), que se trata da metodologia adotada para a execução do passo a passo do processo de _valuation_, que engloba desde a fase de entendimento do problema, entendimento e tratamento dos dados, até a fase de validação e implementação do modelo. Também nesta seção será explicado a execução da metodologia adotada, descrevendo as fontes utilizadas, o tratamento dos dados, a amostra obtida, os critérios e pesos utilizados, a execução do processo de _valuation_, os resultados obtidos e a sua validação.

A penúltima seção se reservará para detalhar e explicar os resultados obtidos do modelo de _valuation_ proposto e das suas variantes, a fim de averiguar a contribuição do MCDM escolhido para a melhora da consistência, rentabilidade e segurança das carteiras selecionadas.

For fim, a última seção apresentará as principais conclusões feitas sobre os resultados e sobre o êxito no alcance dos objetivos almejados.

# **REFERENCIAL TEÓRICO**

Nesta seção, será explicado os principais conceitos teóricos por trás da metodologia adotada, de modo que o leitor entenda e acompanhe o raciocínio empregado para o processo de avaliação das empresas proposta neste trabalho.

## **DEMONSTRAÇÕES CONTÁBEIS**

De acordo com o artigo 176, da Lei 6.404/1976, a Lei das Sociedades por Ações, as demonstrações contábeis, também chamadas de demonstrações financeiras, são relatórios que as sociedades de capital aberto devem elaborar e publicar para informar com clareza sobre a sua posição patrimonial, financeira e o seu desempenho durante o seu exercício social, que geralmente tem duração de um ano.

Dentre as demonstrações financeiras exigidas, as principais para a realização de análises de _valuation_ são o Balanço Patrimonial (BP), a Demonstração de Resultado de Exercício (DRE) e a Demonstração do Fluxo de Caixa (DFC).

### **Balanço Patrimonial (BP)**

O BP busca resumir a situação patrimonial da empresa, geralmente estruturado em forma de “T”, em que se convencionou que o lado esquerdo são listados os bens e direitos (aplicações de recursos), enquanto no lado direito são listados as obrigações e o patrimônio líquido da empresa (fontes de recursos).

Ribeiro (2010) explica que o lado direito, chamado de passivo do balanço, representa as origens de financiamento da empresa, em que as obrigações englobam recursos obtidos de terceiros (capital de terceiros) e o patrimônio líquido, os recursos oriundos dos sócios ou dos lucros apurados após o exercício (capital próprio). O lado esquerdo, por sua vez, chamado de ativo do balanço, reúne as aplicações dos financiamentos, isto é, mostra onde a empresa aplicou o capital obtido. Por consequência dessa definição, o somatório do lado do ativo deve ser igual ao lado do passivo, daí o motivo do termo _Balanço_ Patrimonial, pois os dois lados devem estar equilibrados, assim como uma balança (RIBEIRO, 2010).

Os bens e direitos devem estar ordenados no [BP](#bp) em ordem decrescente de seu grau de liquidez (isto é, quão pouco tempo leva para transformar bens e direitos em dinheiro), dividindo o lado esquerdo em dois grandes grupos: Ativo Circulante e Não Circulante. Enquanto as dívidas e obrigações devem estar ordenadas em ordem decrescente de seu grau de exigibilidade (isto é, pelo quão curto é o prazo para o seu cumprimento), o que os divide em dois grupos: Passivo Circulante e Não Circulante. Além disso, o lado direito também inclui o Patrimônio Líquido (PL) dos sócios.

A [Tabela 1](#table1) exemplifica um modelo de Balanço Patrimonial e as contas que podem compor os ativos e passivos de uma empresa.

<table id="table1" style="text-align:center;">
    <caption style="text-align:center;"><strong>Tabela 1 – Modelo de Balanço Patrimonial</strong></caption>
    <thead>
        <tr>
            <th style="text-align: center">ATIVO</th>
            <th style="text-align: center">PASSIVO</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>CIRCULANTE</td>
            <td>CIRCULANTE</td>
        </tr>
        <tr>
            <td>
                <ul style="list-style-type:none">
                    <li>Disponibilidades</li>
                    <li>Clientes</li>
                    <li>Estoque</li>
                    <li>Tributos a recuperar</li>
                </ul>
            </td>
            <td>
                <ul style="list-style-type:none">
                    <li>Fornecedores</li>
                    <li>Empréstimos e financiamentos</li>
                    <li>Obrigações tributárias</li>
                    <li>Obrigações trabalhistas e previdenciárias</li>
                    <li>Participações e destinações do lucro líquido</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>NÃO CIRCULANTE</td>
            <td>NÃO CIRCULANTE</td>
        </tr>
        <tr>
            <td rowspan="3">
                <ul style="list-style-type:none">
                    <li>Direitos a receber a longo prazo</li>
                    <li>Investimentos</li>
                    <li>Imobilizado</li>
                    <li>Intangível</li>
                </ul>
            </td>
            <td>
                <ul style="list-style-type:none">
                    <li><em>Pode configurar as mesmas contas do passivo circulante, porém vencíveis após o término do exercício social.</em></li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>PATRIMÔNIO LÍQUIDO</td>
        </tr>
        <tr>
            <td>
                <ul style="list-style-type:none">
                    <li>Capital Social</li>
                    <li>Reservas de Capital</li>
                    <li>Reservas de Lucros</li>
                    <li>Ações em Tesouraria</li>
                    <li>Prejuízos Acumulados</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>ATIVO TOTAL</td>
            <td>PASSIVO TOTAL</td>
        </tr>
        <tr>
            <td colspan="2">
                <p>Fonte: Adaptado de Ribeiro (2010)</p>
            </td>
        </tr>
    </tbody>
</table>

### **Demonstração de Resultado de Exercício (DRE)**

A <abbr title="Demonstração de Resultado de Exercício">DRE</abbr> busca documentar o desempenho econômico da empresa, isto é, se ela teve lucro ou prejuízo por meio das suas operações ou do seu resultado financeiro. Geralmente, o exercício social considerado é de um ano.

Segundo Ribeiro (2010), a <abbr title="Demonstração de Resultado de Exercício">DRE</abbr> serve para evidenciar a composição do resultado de uma empresa, mostrando os vários níveis do seu desempenho econômico mediante confronto entre as suas receitas e seus respectivos custos e despesas. Ele explica que a <abbr title="Demonstração de Resultado de Exercício">DRE</abbr> é composta por contas de resultado e por contas patrimoniais, sendo as primeiras correspondentes às receitas realizadas bem como aos custos e despesas incorridas no exercício; enquanto as últimas, às deduções e participações de resultados.

A [Tabela 2](#table2) exemplifica um modelo de DRE e as possíveis contas que a compõe.

<table id="table2">
    <caption style="text-align:center;"><strong>Tabela 2 – Modelo de DRE</strong</caption>
    <thead>
        <tr>
            <th style="text-align:center">CONTA</th>
            <th style="text-align:center">EXEMPLOS</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>(+) Receita Operacional Bruta</td>
            <td>
                <ul>
                    <li>Vendas de mercadorias</li>
                    <li>Prestação de serviços</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>(-) Deduções e Abatimentos</td>
            <td>
                <ul>
                    <li>Vendas Anuladas</li>
                    <li>Descontos Incondicionais Concedidos</li>
                    <li>ICMS sobre as vendas</li>
                    <li>PIS/COFINS sobre faturamento</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>(=) Receita Operacional Líquida</td>
            <td></td>
        </tr>
        <tr>
            <td>(-) Custos Operacionais</td>
            <td>
                <ul>
                    <li>Custos das mercadorias vendidas</li>
                    <li>Custos dos serviços prestados</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>(=) Lucro Operacional Bruto</td>
            <td></td>
        </tr>
        <tr>
            <td>(-) Despesas Operacionais</td>
            <td>
                <ul>
                    <li>Despesas com vendas</li>
                    <li>Despesas Gerais e Administrativas</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>(=) EBITDA</td>
            <td>
                <ul>
                    <li>Resultado do exercício antes das deduções</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>(-) Amortizações</td>
            <td>
                <ul>
                    <li>Pagamento do principal</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>(-) Depreciação</td>
            <td>
                <ul>
                    <li>Depreciação de equipamentos e máquinas</li>
                    <li>Depreciação de imóveis</li>
                    <li>Depreciação de veículos</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>(=) EBIT</td>
            <td>
                <ul>
                    <li>Resultado antes dos impostos e despesas financeiras</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>(-) Impostos</td>
            <td>
                <ul>
                    <li>CSSL</li>
                    <li>IR</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>(+) Resultado Não Operacional</td>
            <td>
                <ul>
                    <li>Venda de Veículos</li>
                    <li>Venda de Terrenos</li>
                    <li>Ganhos ou perdas judiciais</li>
                    <li>Resultados de outras atividades não operacionais</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>(-) Despesas Financeiras</td>
            <td>
                <ul>
                    <li>Pagamento de juros</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>(+) Receitas Financeiras</td>
            <td>
                <ul>
                    <li>Rendimentos de aplicações financeiros</li>
                    <li>Prêmios sobre resgate de títulos e debêntures</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>(=) Resultado do exercício após as deduções</td>
            <td></td>
        </tr>
        <tr>
            <td>(-) Participações</td>
            <td>
                <ul>
                    <li>Debêntures</li>
                    <li>Empregados</li>
                    <li>Administradores</li>
                    <li>Partes Beneficiárias</li>
                </ul>
            </td>
        </tr>
            <tr>
                <td>(=) Lucro Líquido</td>
                <td>
                    <ul>
                        <li>Resultado do exercício social</li>
                    </ul>
                </td>
            </tr>
        <tr>
            <td colspan="2" style="text-align:center">Fonte: Adaptado de Ribeiro (2010)</td>
        </tr>
    </tbody>
</table>

### **Demonstração de Fluxo de Caixa (DFC)**

Fluxos de caixa são todas as saídas (créditos) e entradas (débitos) da conta caixa da empresa e seus equivalentes. Segundo Ribeiro (2010), o conceito de caixa e seus equivalentes engloba todo tipo de conta ou aplicação financeira com liquidez e disponibilidade imediata tais como a própria conta Caixa, Banco conta Movimento, Aplicações Financeiras de Liquidez Imediata, caderneta de poupança, CDB etc.

A DFC, por sua vez, visa evidenciar todas as transações realizadas nas disponibilidades de empresa, incorridas durante o exercício social. De acordo com o inciso I do artigo 188 da Lei 6.404/1976, os fluxos devem estar segregados na estrutura da DFC em, no mínimo, três grupos: fluxos das operações, dos financiamentos e dos investimentos.

A [Tabela 3](#table3) exemplifica um modelo de DFC e suas possíveis transações.

<table id="table3">
    <caption  style="text-align:center;"><strong>Tabela 3 – Modelo de DFC</strong></caption>
    <thead>
        <tr>
            <th style="text-align:center">DESCRIÇÃO</th>
            <th style="text-align:center">EXEMPLOS</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan="2" style="text-align:center"><strong>FLUXOS OPERACIONAIS</strong></td>
        </tr>
        <tr>
            <td>Resultado do exercício/período</td>
            <td>
                <ul>
                    <li>Ajustes para conciliar o resultado às disponibilidades geradas pelas atividades operacionais</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>Depreciação e Amortização</td>
            <td></td>
        </tr>
        <tr>
            <td>Resultado na venda de ativos permanentes</td>
            <td></td>
        </tr>
        <tr>
            <td>Equivalência patrimonial</td>
            <td></td>
        </tr>
        <tr>
            <td>Recebimento de lucros e dividendos de subsidiárias</td>
            <td>
                <ul>
                    <li>Variações nos ativos e passivos</li>
                    <li>Variação em Contas a Receber</li>
                    <li>Variação dos Estoques</li>
                    <li>Variação da conta Fornecedores</li>
                    <li>Variação em Contas a Pagar e provisões</li>
                    <li>Variação no IR e CSSL</li>
                    <li>Disponibilidades líquidas geradas pelas (aplicadas nas) atividades operacionais</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align:center"><strong>FLUXOS DE INVESTIMENTOS</strong></td>
        </tr>
        <tr>
            <td>Imobilizado</td>
            <td>
                <ul>
                    <li>Compras do Imobilizado</li>
                    <li>Vendas do Imobilizado</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>Ações/quotas</td>
            <td>
                <ul>
                    <li>Aquisição ações/cotas</li>
                    <li>Venda de ações/cotas</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>Recebimento por vendas de ativos não circulantes</td>
            <td>
                <ul>
                    <li>Disponibilidades líquidas geradas pelas (aplicadas nas) atividades operacionais</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align:center"><strong>FLUXOS DE FINANCIAMENTOS</strong></td>
        </tr>
        <tr>
            <td><Capital</td>
            <td>
                <ul>
                    <li>Integralização de capital</li>
                    <li>Pagamento de lucros/dividendos</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>Empréstimos</td>
            <td>
                <ul>
                    <li>Empréstimos tomados</li>
                    <li>Pagamentos de empréstimos/debêntures</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>Juros</td>
            <td>
                <ul>
                    <li>Juros recebidos de empréstimos</li>
                    <li>Juros pagos por empréstimos</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align:center"><strong>VARIAÇÃO DAS DISPONIBILIDADES</strong></td>
        </tr>
        <tr>
            <td colspan="2" style="text-align:center">Fonte: Adaptado de Ribeiro (2010)</td>
        </tr>
    </tbody>
</table>

## **VALUATION**

Para que um bom investimento seja feito, é necessário que o investidor não pague caro demais por um ativo para que não perca o seu potencial de retorno, nem o venda barato demais, pois representaria um significativo custo de oportunidade. Ao se comparar a cotação de uma ação com seu valor intrínseco, o investidor encontrará o que Graham (2016) chama de margem de segurança (MS), dada pelo seu potencial de valorização. Portanto, teoricamente, quanto maior fosse essa margem, mais seguro e certo era de estar investido nessa ação.

Porém, Damodaran (2012) salienta que estimar o valor intrínseco de uma ação não é uma tarefa simples.

Primeiramente, toda análise de _valuation_ é inevitavelmente tendenciosa, pois os avaliadores nunca partem de uma tábula rasa, já tendo opiniões, preconceitos e julgamentos sobre a empresa ou seu setor de atuação antes mesmo do início da avaliação, muitas vezes ocasionado pelo acompanhamento de rumores, comentários, opiniões ou avaliações de outros analistas (DAMODARAN, 2012). Por isso, não é incomum haver analistas terem avaliações otimistas, pessimistas e incertas sobre um mesmo ativo ao mesmo tempo, pois todos partiram de premissas ou modelos que diferem entre si (por exemplo, taxas de crescimento distintas, previsões distintas sobre a evolução das variáveis macroeconômicas, horizontes de projeção com intervalos diferentes, consideração ou não de um valor de perpetuidade etc.).

Segundo, até mesmo as melhores avaliações podem conter imprecisões. Mesmo se as informações sobre os resultados de uma empresa fossem impecáveis e completamente disponíveis ao público, ainda seria necessário projetá-los, o que acarreta sempre em erros de estimativa nas previsões. E, ainda, mesmo que a empresa evolua conforme as expectativas, o ambiente macroeconômico pode sofrer mudanças acentuadas, e até mesmo imprevisíveis. (DAMODARAN, 2012).

Por isso, como recomendado pelo autor, se for possível modelar bem a análise de _valuation_ com a menor quantidade de _inputs_ necessários possível, menor serão as chances de ocorrerem erros e distorções nas estimativas, pois um modelo complexo sempre terá um custo compensatório de ser menos inteligível, mais opaco e de necessitar um maior intervalo de confiança para os resultados obtidos. Portanto, nesse caso, menos é mais. (DAMODARAN, 2012).

Dado esse contexto, uma pessoa pode chegar à conclusão de que o processo de _valuation_ é mais um parecer altamente subjetivo do que um procedimento científico, já que é altamente dependente das premissas adotadas pelo avaliador. Porém, Damodaran (2012) esclarece que, apesar dessas verdades, elas não são razões suficientes para não aplicar _valuation_ nas análises de investimentos, pois todo modelo, até mesmo os científicos, são intrínsicamente imprecisos, uma vez que buscam ser uma representação simplificada da realidade. Além disso, o grande sucesso dos investimentos reside em não acertar sempre, mas sim em consistentemente acertar mais do que errar. (DAMODARAN, 2012).

Existem vários tipos de modelos de _valuation_ e a sua complexidade aceitada dependerá majoritariamente da relação custo-benefício entre o tempo necessário para a sua realização e a sua precisão desejada. Um exemplo simples, proposta por Graham (2016), envolve a determinação do valor intrínseco da ação ($VIA$) pela equação:

<span id="eq2-1">

$$
\begin{array}{lr}
    VIA = \sqrt{22.5 \times LPA \times VPA} & \text{(2.1)}
\end{array}
$$

</span>

Onde:

- $LPA$ é o lucro dos últimos 12 meses por ação;
- $VPA$ é o valor patrimonial por ação.

Donde o investidor pode estimar a margem de segurança como sendo:

<span id="eq2-2">

$$
\begin{array}{lr}
    MS = \frac{VIA - P}{P} \times 100 \text{\%} & \text{(2.2)}
\end{array}
$$

</span>

Onde $P$ é o preço da ação.

Já os modelos mais complexos podem envolver Fluxo de Caixa Descontado Estocástico, simulações, métodos de Monte Carlo, IA, _Machine Learning_, etc., dependendo das necessidades do avaliador.

Apesar dos diversos tipos de modelos de _valuation_, Damodaran (2012) os agrupa em duas abordagens: _intrínseca_ e _comparativa_. A primeira envolve a avaliação da ação a partir dos fluxos de caixa gerados pela empresa, enquanto a segunda envolve a avaliação da ação a partir da sua comparação com ações de empresas semelhantes. O modelo mais utilizado para a abordagem intrínseca é o FCD, enquanto a abordagem comparativa comumente emprega a comparação de múltiplos, também conhecidos como indicadores fundamentalistas.

### **Fluxo de Caixa Descontado (FCD)**

Os modelos de FCD partem do princípio de que o valor do dinheiro no futuro é sempre menor do que o seu valor presente, pois é sempre preferível receber, por exemplo, R$ 1.000,00 agora do que esperar para receber a mesma quantia em qualquer período futuro. Tal desvalorização do dinheiro é determinada por uma taxa de desconto, que é proporcional ao risco assumido de ter de esperar para recebê-lo.

Por conta disso, conforme explicado por Damodaran (2012) e Filho _et al._ (2008), os modelos de FCD determinam que valor de um ativo é determinado pelo valor presente dos seus fluxos de caixa futuros, descontados por uma taxa que reflete o risco admissível de se investir no ativo. Portanto, a partir desta definição, o valor de um imóvel é determinado pelos fluxos dos aluguéis; o valor das debêntures, pelo fluxo dos juros; das patentes, pelos royalties; e o valor das ações, pelo fluxo de dividendos projetados (FILHO _et al.,_ 2008).

A equação a seguir apresenta a fórmula geral comumente empregada para a determinação do valor presente de um ativo.

<span id="eq2-3">

$$
\begin{array}{lr}
    VIA = \sum_{t=1}^{n}{\frac{FCL_{t}}{(1+r)^t}} & \text{(2.3)}
\end{array}
$$

</span>

Onde:

- $VIA$ é o valor presente ou valor intrínseco do ativo;
- $FCL_{t}$ é o fluxo de caixa livre do período $t$, após pagamento de impostos, juros e despesas;
- $r$ é a taxa de desconto;
- $n$ é o número de períodos esperados para a geração do fluxo de caixa.

No entanto, para modelos em que se admite que o ativo gerará fluxo de caixa permanentemente, – como é o caso na avaliação de ações, já que não se espera que os sócios abram a empresa com expectativas que de seus negócios se findem – é comum incluir mais uma parcela à [Equação (2.3)](#eq2-3).

<span id="eq2-4">

$$
\begin{array}{lr}
    VIA = \underbrace{\sum_{t=1}^{n}{\frac{FCL_{t}}{(1+r)^t}}}_{V_{hp}} + \underbrace{\frac{VT}{(1+r)^n}}_{V_p} & \text{(2.4)}
\end{array}
$$

</span>

Onde:

- $V_{hp}$ é o valor presente do fluxo de caixa livre do ativo no horizonte de projeção;
- $V_p$ é o valor presente do fluxo de caixa livre do ativo na perpetuidade;
- $n$ é o intervalo de projeção antes da perpetuidade;
- $VT$ é o valor terminal (ou residual) do fluxo de caixa na perpetuidade.

Para o cálculo do $VT$, geralmente é empregado o modelo de crescimento perpétuo de Gordon.

#### **Modelo de Gordon**

O modelo de Gordon foi originalmente proposto por J. B. Williams, mas que recebeu o sobrenome de M. J. Gordon, que divulgou em 1956 o modelo de crescimento perpétuo (FILHO et al., 2008).

Este modelo parte da premissa de que os dividendos esperados de uma ação crescem em uma PG, a uma taxa $g$ a cada período $t$, admitindo que uma empresa, em constante crescimento, pagaria dividendos sempre crescentes. Assim, a partir do último dividendo distribuído $D_0$, projetar-se-ia os dividendos futuros como:

$$ D_1 = D_0(1+g) $$
$$ D_2 = D_0(1+g)^2 $$
$$ \vdots $$
$$ D_t = D_0(1+g)^n $$

Portanto, o valor intrínseco de uma ação seria determinado pelo somatório de todos os dividendos descontados a uma taxa $r$.

$$ VIA = \sum_{t=1}^{\infty}{\frac{D_0(1+g)^t}{(1+r)^t}} = D_0\sum_{t=1}^{\infty}{(\frac{1+g}{1+r})^t} $$

No entanto, para que o valor presente da ação convirja para um número finito, é necessário que a razão $q$ da PG infinita seja estritamente menor do que 1. Logo:

$$ q = \frac{1+g}{1+r} \lt 1 \implies 1 + g \lt 1+r \implies g \lt r $$

Ou seja, a taxa de crescimento perpétuo dos dividendos deve ser menor do que a taxa de desconto. Como observado por Damodaran (2012) e Filho et al. (2008), presumir que a taxa $g$ se mantenha constante no infinito implica em também presumir que a taxa de crescimento dos lucros da empresa se mantenha, no mínimo, igual a $g$. Pois, caso contrário, não seria possível manter a taxa de crescimento dos dividendos infinitamente. E para que a taxa de crescimento dos lucros se mantenha constante infinitamente, é necessário que a taxa $g$ seja menor do que a média da taxa de crescimento nominal da economia como um todo. Pois do contrário, isto é, se for assumido que a taxa de crescimento dos dividendos se mantenha maior do que a da economia infinitamente, implicará dizer que os lucros da empresa crescem mais do que a economia indefinidamente, o que a levaria eventualmente a ocupar a sua totalidade. Portanto, chegaríamos a um absurdo.

Admitindo que tal condição seja cumprida, pode-se calcular o valor da soma da PG infinita por:

$$ \sum_{t=1}^{\infty}{(\frac{1+g}{1+r})^t} = \frac{q}{1-q} = \frac{\frac{1+g}{1+r}}{1-\frac{1+g}{1+r}} = \frac{1+g}{1+r-1-g} = \frac{1+g}{r-g} $$

Portanto, o valor presente de uma ação pelo modelo de Gordon será de:

<span id="eq2-5">

$$
\begin{array}{lr}
    VIA = \frac{D_{0}(1+g)}{r-g} & \text{(2.5)}
\end{array}
$$

</span>

Apesar de ser um modelo bem criticado por assumir uma premissa considerada bastante irrealista para muitas empresas, tendo a sua aplicação limitada para empresas com crescimento estável, ele é um bom exemplo intuitivo sobre como as principais variáveis afetam o preço de uma ação.

Conforme apontado por Filho et al. (2008), o modelo de Gordon não apenas demonstra claramente que o aumento na distribuição de dividendos eleva o preço da ação, mas também revela que um aumento na taxa de retorno $r$ – mantendo $g$ constante – reduz o valor da ação. Isso geralmente ocorre quando os investidores percebem um aumento no risco associado à empresa.

No entanto, como ressaltado também por Filho et al. (2008), embora o aumento de $D_0$ aumente o $VIA$, isso acaba implicando em uma redução em $g$, pois a empresa terá menos recursos disponíveis para investimentos de capital (CAPEX). Consequentemente, o denominador $(r-g)$ aumenta, resultando em uma diminuição compensatória do valor da ação. De maneira similar, o oposto ocorre quando $D_0$ diminui. Embora a distribuição de dividendos diminua o $VIA$, a empresa terá mais recursos para investimentos de capital. Assim, $g$ aumenta e o denominador $(r-g)$ diminui, o que leva a um aumento compensatório no preço da ação.

#### **FCFE**

O modelo de Fluxo de Caixa Livre para os Acionistas busca, primeiramente, estimar qual o valor intrínseco de mercado $VIM$ da empresa a partir do desconto dos fluxos de caixa pertencentes exclusivamente aos acionistas após o pagamento das despesas, impostos e amortização de dívidas.

<span id="eq2-6">

$$
\begin{array}{lr}
    VIM = \sum_{t=1}^{n}{\frac{FCFE_t}{(1+r)^t}} + \frac{VT}{(1+r)^n} & \text{(2.6)}
\end{array}
$$

</span>

Onde:

- $n$ é o período de projeção;
- $FCFE_t$ é o fluxo de caixa livre para os acionistas no período $t$;
- $r$ é a taxa de desconto que, neste modelo, representará o custo do capital próprio da empresa;
- $VT = \frac{FCFE_n(1+g)}{r-g}$ é o valor terminal do fluxo após o período de projeção;
- $g$ é a taxa de crescimento da empresa na perpetuidade;

Com o valor de mercado estimado, divide-se pelo número de ações emitidos no mercado para obter o valor intrínseco da ação.

<span id="eq2-7">

$$
\begin{array}{lr}
    VIA = \frac{VIM}{N} & \text{(2.7)}
\end{array}
$$

</span>

Onde $N$ é o número de ações emitidas da empresa.

A projeção dos $FCFE_t$, para $1 \le t \le n$, deve ser realizado com base nos FCFEs históricos, cujo cálculo pode ser feita pela fórmula geral apresentada por Kobori (2018), dada por:

<span id="eq2-8">

$$
\begin{array}{lr}
    FCFE = FCO + FCI + FCF & \text{(2.8)}
\end{array}
$$

</span>

Onde:

- $FCO$ é o Fluxo de Caixa Operacional, que corresponde ao lucro líquido mais as despesas não desembolsáveis, como depreciação, amortização exaustão etc., e a necessidade de capital de giro ( KOBORI, 2018);
- $FCI$ é o Fluxo de Caixa dos Investimentos, que corresponde à soma de todos os investimentos e desinvestimentos de capital, como compras ou vendas de máquinas, equipamentos, móveis, instalações etc., necessários para manter a geração de caixa da empresa em situações de estabilidade ( KOBORI, 2018). Compras representam saídas de caixa (parcelas negativas), enquanto vendas, entradas de caixa (parcelas positivas);
- $FCF$ é o Fluxo de Caixa dos Financiamentos, que corresponde à soma dos empréstimos e financiamentos captados pela empresa e as amortizações e pagamentos de dívidas. Esta parcela também inclui os recursos recebidos dos sócios e a distribuição de dividendos ( KOBORI, 2018);

Entretando, Damodaran (2012), Póvoa (2012) e Reis (2023), falam que os FCFEs históricos também podem ser calculados conforme o procedimento apresentado pela [Tabela 4](#table4).

<table id="table4" style="text-align:center">
    <caption style="text-align:center;"><strong>Tabela 4 – Cálculo do FCFE</strong></caption>
    <thead>
        <tr>
            <th style="text-align:center">PARCELA</th>
            <th style="text-align:center">SÍMBOLO</th>
            <th style="text-align:center">EXPLICAÇÃO</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>(+) Lucro Líquido do Exercício</td>
            <td><em>LL</em></td>
            <td>Já tendo sido realizado o pagamento de juros e amortizações.</td>
        </tr>
        <tr>
            <td>(+) Depreciação</td>
            <td><em>DP</em></td>
            <td>É adicionado de volta já que serviu apenas para efeito de cálculo da base tributária.</td>
        </tr>
        <tr>
            <td>(-) Despesas de capital</td>
            <td><em>CAPEX</em></td>
            <td>Despesas de capital.</td>
        </tr>
        <tr>
            <td>(-) Variação da necessidade de capital de giro</td>
            <td><em>&Delta;NCG</em></td>
            <td>Os aumentos em estoque e em contas a receber reduzem a geração de caixa; os aumentos em contas a pagar aumentam a geração de caixa.</td>
        </tr>
        <tr>
            <td>(+) Captação de novos financiamentos</td>
            <td><em>F</em></td>
            <td>Emissão de novas dívidas.</td>
        </tr>
        <tr>
            <td>(=) Fluxo de Caixa Livre para os Acionistas.</td>
            <td><em>FCFE</em></td>
            <td>Este é o caixa que sobra depois do atendimento de todas as necessidades. Se for positivo, representa um dividendo potencial</td>
        </tr>
        <tr>
            <td colspan=3 style="text-align:center">Fonte: Adaptado de Damodaran (2012) e Póvoa (2012)</td>
        </tr>
    </tbody>
</table>

Além das projeções dos $FCFE_t$, um outro desafio para o cálculo do $VIM$ é a determinação da taxa de custo de capital próprio ($r$) mais apropriada. Neste trabalho, foi adotado o modelo CAPM para o cálculo dessa taxa.

#### **Modelo CAPM**

Segundo Damodaran (2012), um dos modelos mais empregados para a determinação do custo do capital próprio é o CAPM, desenvolvido no início da década de 1960. Partindo da hipótese de que a diversificação de ativos não traz custos adicionais nem aumento de ganhos, então a melhor carteira de ações seria aquela que compõe todas as ações negociadas na bolsa, isto é, a _carteira de mercado_. Nesse cenário, o risco de um ativo seria equivalente ao seu risco adicional à carteira de mercado, representado pelo indicador $\beta$, calculado por:

<span id="eq2-9">

$$
\begin{array}{lr}
    \beta_i = \frac{\text{Cov}(R_i, R_m)}{\sigma^2(R_m)} & \text{(2.9)}
\end{array}
$$

</span>

Onde:

- $\beta_i$ é o risco incremental da ação $i$
- $R-i$ são os retornos percentuais da ação $i$
- $R_m$ são os retornos percentuais do mercado
- $\text{Cov}(R_i,R_m)$ é a covariância entre os retornos médios da ação $i$ e do mercado
- $\sigma^2(R_m)$ é a variância dos retornos do mercado

Segundo Póvoa (2012), o $\beta$ pode ser interpretado como o nível de sensibilidade de uma ação em relação às variações do mercado. Uma ação com $\beta \lt 1$ tende a ser menos sensível às variações de mercado. Ou seja, o preço da ação tende a cair menos quando o mercado cai e vice-versa. Já uma ação com $\beta \gt 1$ é mais sensível aos movimentos do mercado, pois significa que em momentos de queda do mercado, o seu preço tende a cair mais que o próprio mercado, e vice-versa. Por fim, $\beta = 1$ significa que as variações do preço da ação tendem refletir as variações do próprio mercado.

Ainda segundo Póvoa (2012), uma outra forma de calcular o $\beta_i$ de uma ação é calculando o coeficiente angular da regressão linear entre os retornos da ação e o os retornos do mercado. O índice mais comumente adotado para representar a carteira do mercado brasileiro é o Ibovespa, que busca simular uma carteira teórica dos ativos mais negociados na Bolsa de Valores de São Paulo (B3, 2023).

Partindo das hipóteses anteriormente mencionadas, o CAPM diz que o retorno esperado de uma ação será dado por:

<span id="eq2-10">

$$
\begin{array}{lr}
    r = R_f + \beta_i (E[R_m]-R_f) & \text{(2.10)}
\end{array}
$$

</span>

Onde:

- $R_f$ é a taxa livre de risco
- $E[R_m]$ é o valor esperado dos retornos do mercado
- $(E[R_m]-R_f)$ é o prêmio pelo risco

A lógica por trás da fórmula é a de que, ao investir em um ativo com risco, o investidor deverá exigir uma taxa equivalente à taxa que um ativo livre de riscos renderia, mais um prêmio por estar investindo no ativo com risco. Portanto, quanto maior for a sensibilidade do ativo em relação aos movimentos do mercado – isto é, quanto maior for o valor do $\beta_i$ –, maior deverá ser a remuneração pelo risco incorrido.

No entanto, no método de estimação dos FCFEs não se leva em consideração a estrutura de capital da empresa, pois não é considerado nenhum outro capital além do seu capital próprio. Portanto, deve-se desconsiderar a sua alavancagem financeira, uma vez que boa parte da volatilidade de suas ações se deve pela proporção das dívidas assumidas (PÓVOA, 2012). Além disso, uma vez que diferentes empresas apresentam diferentes estruturas de capital, o beta a ser utilizado no modelo CAPM deve ser o desalavancado ($\beta_d$), calculado como:

<span id="eq2-11">

$$
\begin{array}{lr}
    \beta_d = \frac{\beta}{1+(1-T)\frac{D}{E}} & \text{(2.11)}
\end{array}
$$

</span>

Onde:

- $\beta$ é o beta original, alavancado;
- $T$ é a alíquota do imposto;

Segundo Damodaran (2012), apesar do CAPM ser intuitivo e simples, ele parte de premissas irrealistas, além do fato de os $\beta_i$ individuais dos ativos não serem eficazes para explicar diferenças de retorno entre diferentes ações. Póvoa (2012) enumera como principais desvantagens do uso dos $\beta_i$ estatísticos (1) a eventual ou recorrente falta de liquidez de uma ação, havendo longos períodos em que ela não é negociada na bolsa, o que pode distorcer bastante o seu $\beta_i$; (2) os desvios-padrão dos $\beta_i$ estatísticos são excessivamente grandes, sendo, portanto, pouco críveis para o cálculo da taxa de desconto $r$; (3) Cálculo dos $\beta_i$ com base em dados históricos, o que não necessariamente reflete a sensibilidade futura do ativo; (4) Uso de índices de referência distorcidos para o seu cálculos, com alguns sendo altamente concentrados em um ou vários setores específicos, não sendo, portanto, bons representantes da carteira de mercado.

Por conta disso, Damodaran (2012) sugere como solução substituir o $\beta_i$ pelo beta médio do setor ($\beta_{\text{setor}}$) em que a empresa se encontra, uma vez que a média de muitos $\beta_i$ atenua o efeito dos erros e das distorções. Póvoa (2012) sugere como cálculo para o $\beta_{\text{setor}}$ a média ponderada pelos valores de mercado $VM_i$ das empresas.

<span id="eq2-12">

$$
\begin{array}{lr}
    \beta_{\text{setor}} = \frac{\sum_{i=1}^{m}{\beta_i VM_i}}{\sum_{i=1}^{m}{VM_i}} & \text{(2.12)}
\end{array}
$$

</span>

Onde $m$ é o total de empresas presentes no setor.

Portanto, a equação recomendada para o cálculo do custo do capital próprio no método de FCFE seria:

<span id="eq2-13">

$$
\begin{array}{lr}
    r = R_f + \beta_{\text{setor}}(E[R_m]-R_f) & \text{(2.13)}
\end{array}
$$

</span>

#### **FCFF**

O modelo de Fluxo de Caixa Livre para a Empresa, diferentemente do FCFE, busca estimar o valor intrínseco da empresa ou da firma ($VIF$), isto é, o valor considerando o capital total alocado na empresa, financiado pelo capital dos sócios e acionistas (capital próprio) e as dívidas e empréstimos dos credores (capital de terceiros). A fórmula do $VIF$ é análoga à do $VIM$.

<span id="eq2-14">

$$
\begin{array}{lr}
    VIF = \sum_{t=1}^{n}{\frac{FCFF_{t}}{(1+r)^t}} + \frac{VT}{(1+r)^n} & \text{(2.14)}
\end{array}
$$

</span>

Onde:

- $r$, neste modelo, é a taxa do custo de capital total da empresa;
- $VT=\frac{FCFF_n(1+g)}{r-g}$é o valor terminal do fluxo de caixa para a empresa na perpetuidade.

Por fim, para a obtenção do valor intrínseco da ação, é necessário retirar a dívida total da empresa do valor da firma e dividir a diferença pelo número total de ações.

<span id="eq2-15">

$$
\begin{array}{lr}
    VIA = \frac{VIF-D}{N} & \text{(2.15)}
\end{array}
$$

</span>

Para o cálculo dos FCFF históricos, é necessário considerar a dívida, já que estamos considerando tanto o capital próprio como de terceiros. Assim, na avaliação dos demonstrativos contábeis, ao invés de se partir do lucro líquido do exercício social, parte-se do EBITDA, por não considerar as deduções dos juros e das amortizações.

<span id="eq2-16">

$$
\begin{array}{lr}
    FCFF = EBITDA(1-T) + DP \dot T - CAPEX - \Delta NCG & \text{(2.16)}
\end{array}
$$

</span>

Em relação à formula geral (2.8), bastaria retirar a parcela FCF para obter o FCFF, ficando portanto:

<span id="eq2-17">

$$
\begin{array}{lr}
    FCFF = FCO + FCI & \text{(2.17)}
\end{array}
$$

</span>

Além dessas adaptações em relação ao FCFE, é necessário salientar que a taxa a ser considerada deve levar em conta não só o custo do capital próprio, como também o de terceiros. Para isso, foi empregado o cálculo do WACC da empresa.

#### **WACC**

O CMPC, como também é conhecido o WACC, estima o custo de capital da empresa considerando tanto o financiamento da empresa pelo capital dos sócios quanto o risco de alavancagem financeira pela tomada de empréstimos de capitais de terceiros. Para isso, é calculado um custo médio das fontes de capital, ponderados pelas suas respectivas proporções em relação ao capital total da empresa.

Segundo Filho et al. (2008), considerando que uma empresa possua fontes de financiamento, com cada uma possuindo uma taxa de custo $r_i$, a fórmula geral para o custo médio ponderado de capital da empresa deverá ser dada por:

<span id="eq2-18">

$$
\begin{array}{lr}
    WACC = \frac{\sum_{i=1}^{n}{C_ir_i}}{\sum_{i=1}^{n}{C_i}} & \text{(2.18)}
\end{array}
$$

</span>

Onde $C_i$ é o total financiado à empresa pela fonte $i$.

Portanto, considerando que as fontes de financiamento possam ser resumidas em capital próprio ($E$) e de terceiros ($D$), com suas respectivas taxas de custo $r_E$ e $r_D$, então a taxa mínima aceitável pelos acionistas deverá ser dada por:

<span id="eq2-19">

$$
\begin{array}{lr}
    WACC = \frac{E}{E+D}r_E + \frac{D}{E+D}r_D(1-T) & \text{(2.19)}
\end{array}    
$$

</span>

O $r_E$ é calculado pelo modelo CAPM, como explicado em um tópico anterior. Neste caso, é necessário fazer uso do beta alavancado ao invés do desalavancado, uma vez que o risco da dívida deverá ser avaliado junto com o risco do próprio negócio. Vale comentar também que o termo representa a alíquota do imposto de renda pago pela empresa e, portanto, o fator $(1-T)$ representa o benefício fiscal que a empresa ganha sobre o cutos do capital de terceiros.

Devido às desvantagens do uso do beta individual $\beta_i$, apresentadas no tópico sobre CAPM, Póvoa (2012) propõe o uso de um _bottom-up_ beta ($\hat{\beta}$) em seu lugar. Esse coeficiente se baseia na regra estatística de que o desvio padrão da média de betas individuais é sempre menor que o desvio-padrão médio dos betas individuais, uma vez que:

<span id="eq2-20">

$$
\begin{array}{lr}
    \sigma(\overline{\beta_i}) = \frac{\overline{\sigma}(\beta_i)}{\sqrt{n}} & \text{(2.20)}
\end{array}  
$$

</span>

Onde:

- $\overline{\beta_i}$ é a média dos betas individuais;
- $\sigma$ é o desvio-padrão;
- $\overline{\sigma}$ é o desvio-padrão médio;
- $n$ é o número de observações.

Para o cálculo do $\hat{\beta_i}$ de uma ação, será necessário realizar a seguinte série de passos:

1. Calcular $\beta_i$ os tradicionais de cada uma das ações das empresas que pertençam ao mesmo setor da empresa $i$.
2. Calcular o beta do setor a partir de uma soma ponderada dos $\beta_i$ de cada empresa, tendo como pesos os valores $VM_i$ negociados no mercado de cada empresa $i$.
3. Calcular a proporção entre capital de terceiros e capital próprio médio do setor a partir da média ponderada, tendo como pesos o valor de mercado das empresas no setor.

<span id="eq2-21">

$$
\begin{array}{lr}
    \overline{\frac{D}{E}} = \frac{\sum_{i=1}^{m}{VM_i}\frac{D_i}{E_i}}{\sum_{i=1}^{m}{VM_i}} & \text{(2.21)}
\end{array}
$$

</span>

4. Uma vez que empresas com maior alavancagem financeiras apresentam maior volatilidade, é necessário calcular o beta desalavancado do setor ($\beta_{d^{\text{setor}}}$) por:

<span id="eq2-22">

$$
\begin{array}{lr}
    \beta_{d^{\text{setor}}} = \frac{\beta_{\text{setor}}}{1+(1-T) \overline{(\frac{D}{E})}} & \text{(2.22)}
\end{array}
$$

</span>

5. Realavancar o $\beta_{d^{\text{setor}}}$ pela alavancagem financeira da empresa $i$ para finalmente obter o seu $\hat{\beta_i}$.

<span id="eq2-23">

$$
\begin{array}{lr}
    \hat{\beta_i} =  \beta_{d^{\text{setor}}}[1 + (1-T)\frac{D_i}{E_i}] & \text{(2.23)}
\end{array}
$$

</span>

Portanto, o custo de capital próprio $r_E$ recomendado por Póvoa (2012) passaria a ser dado por:

<span id="eq2-24">

$$
\begin{array}{lr}
    r_E = R_f + \hat{\beta_i}(E[R_m] - R_f) & \text{(2.24)}
\end{array}
$$

</span>

Por fim, o último _input_ necessário para calcular o WACC é a taxa de custo de capital de terceiros $r_D$, que pode ser facilmente calculada pela razão:

<span id="eq2-25">

$$
\begin{array}{lr}
    r_D = \frac{J}{D} & \text{(2.25)}
\end{array}
$$

</span>

Onde $J$ é o total das despesas financeiras.

### **Avaliação Comparativa**

A avaliação comparativa se trata de determinar o valor de um ativo comparando-o com outros ativos semelhantes. Por exemplo, para determinar o valor de um veículo, algumas pessoas poderiam pesquisar pelos preços de outros veículos semelhantes – veículos que sejam do mesmo modelo, tenham a cilindrada parecida, mesma tração ou com aproximadamente a mesma quantidade de metros cúbicos de espaço etc. –, calcular uma média e comparar com o preço cotado pelo veículo no mercado e verificar se o preço é razoável.

Segundo Damodaran (2012), há três passos a serem seguidos neste tipo de avaliação: (1) Determinar os ativos comparáveis; (2) Padronizar os valores de mercado a valores comparáveis; (3) Comparar os valores padronizados, fazendo os devidos ajustes que considerem as diferenças dos ativos.

Empresas comparáveis, segundo o autor, são aquelas com capacidade de geração de caixa, potencial de crescimento e riscos semelhantes. Póvoa (2012), por sua vez, leva em conta a ciclicidade, a alavancagem operacional e diferenciação do produto/especialização da empresa como critérios para segmentação de empresas comparáveis. No entanto, como é ressaltado por Póvoa (2012), é sempre importante privilegiar a simplicidade à complexidade nos processos de _valuation_. Caso haja um alto detalhamento dos critérios para segmentação das empresas, corre-se o risco do avaliador cair no paradoxo de “segmentos formados por uma ou duas empresas”, o que acabará por comprometer a análise comparativa por se estar lidando com amostras muito diminutas.

Por isso, apesar das definições apresentadas não terem algum critério pertinente à indústria ou ao setor em que a empresa atua, é bastante comum que os analistas definam “empresas comparáveis” como aquelas que possuam o mesmo modelo de negócio ou que atuam no mesmo setor. Por questão de simplicidade, foi definido neste trabalho empresas comparáveis como aquelas que atuam em um mesmo setor da economia ou que possui o conjunto majoritário de suas atividades e operações pertencentes ao mesmo setor.

No que tange à escolha de valores padronizados, um dos mais adotados são indicadores fundamentalistas, como o P/L, P/VP, ROE, ROA, margem líquida etc. Para a escolha dos indicadores, Damodaran (2012) alerta que eles devem ser consistentes. Como o próprio autor exemplifica, o índice P/L pode ser calculado de várias formas – com base no lucro do último exercício social, dos últimos 12 meses, dos próximos 12 meses etc. – e é recomendável que apenas uma definição seja aplicada a todas as empresas para que se tenha uma comparação válida.

Como parte da metodologia deste trabalho, a comparação entre os indicadores das empresas se dará pela distância que esta estará da empresa anti-ideal do setor (NIS) e da empresa ideal do setor (PIS). Uma explicação mais detalhada se encontrará na seção sobre o método TOPSIS.

A seguir, serão explicados os principais indicadores fundamentalistas considerados para a realização da avaliação comparativa.

#### Volume de negociações

Representa o volume de negociações da ação de uma empresa nos últimos 30 dias. Esse indicador será usado tanto como um critério no TOPSIS quanto como critério de unicidade. Isto é, caso uma empresa esteja sendo negociada na bolsa em mais de um tipo de ação, apenas a ação mais líquida entrará para o conjunto de alternativas do modelo TOPSIS.

#### P/L

Segundo Gitman (2013), a relação preço/lucro mede o montante que os investidores estão dispostos a pagar por cada unidade monetária do lucro de uma ação. Neste trabalho, foi calculado pela razão entre o preço da ação e o lucro líquido por ação dos últimos 12 meses. Portanto, ele representa o preço do lucro auferido pela empresa nos últimos 12 meses. Por exemplo, se uma ação está sendo negociada na bolsa com P/L = 10, significa que os investidores estão dispostos a comprar R$ 1,00 dos lucros da empresa por R$ 10,00.

Uma segunda interpretação deste indicador é a quantidade de anos do retorno da ação. Portanto, um investidor que comprou uma ação quando seu P/L = 10, significa que, caso os lucros da empresa se mantenham constantes, e caso o lucro auferido fosse totalmente distribuído aos acionistas, então o investidor verá o retorno total do seu investimento em 10 anos.

Por isso, melhor será para o investidor quanto menor for valor do P/L de uma ação, ainda mais quando o P/L pequeno não for justificável, pois significa que uma ação boa está sendo subprecificada. No entanto, isso só vale enquanto P/L for positivo. Quando P/L < 0, significa que a empresa vem tendo prejuízo nos últimos 12 meses.

#### P/VP

Segundo Gitman (2013), a relação preço-valor patrimonial é calculado pela razão entre o valor de mercado da empresa e o seu PL. Ou ainda, pela razão entre o preço da ação e o patrimônio líquido por ação (LPA). Portanto, ele fornece uma avaliação de como os investidores encaram o desempenho de uma empresa e ele representa o quanto os investidores estão dispostos a comprar para cada unidade monetária do patrimônio líquido contábil da empresa. Por exemplo, se uma ação está sendo negociada na Bolsa com P/VP = 5, significa que os investidores estão dispostos a comprar R$ 1,00 do PL da empresa por R$ 5,00.

Como o site da Status Invest (2020) explica, quando um P/VP é baixo, com valor abaixo de 1, indica que a empresa está sendo negociada por um valor de mercado menor do que o seu patrimônio líquido, o que pode revelar uma oportunidade de potencial de valorização daquela ação.

Por conta disso, melhor para o investidor quanto menor for o valor de P/VP. Porém, da mesma forma como ocorre com o P/L, este indicador passa a ser indesejável quando P/VP < 0, pois significa que a empresa possui um patrimônio líquido negativo, isto é, possui mais dívidas e obrigações do que bens ou direitos.

#### Dividend Yield (DY)

O DY é calculado pela razão entre o somatório dos dividendos por ação pagos pela empresa nos últimos 12 meses e o preço da ação. Ele é um indicador de performance no pagamento de dividendos de uma ação. Por exemplo, uma ação com DY = 10% significa que, nos últimos 12 meses, ela pagou R$ 0,10 de dividendos para cada R$ 1,00 do seu preço atual.

Portanto, quanto maior o DY de uma ação, mais interessante é de investir nela. Porém, como a própria Status Invest (2021) alerta, devido ao fato desse indicador estar relacionado inversamente com o preço da ação, um investidor pode chegar erroneamente na conclusão de que a empresa é boa pagadora de dividendos quando o preço do seu papel está bem subprecificada. Além disso, pode acontecer de uma ação ter um DY bem alto devido a uma distribuição de lucros extraordinários não provenientes da sua operação, mas de um fato não recorrente, como ganhos judiciais, desinvestimentos, vendas de terrenos etc.

#### Margem Líquida

Segundo Kobori (2018), a margem líquida é a razão entre o lucro líquido e as receitas, isto é, o quanto de lucro a empresa gera a cada R$ 100,00 em receita líquida (RL). Por exemplo, uma empresa que possui uma margem líquida de 30% consegue auferir, em média, R$ 30,00 de lucro a cada R$ 100,00 de receita (seja vendas de produtos ou prestação de serviços). Neste, trabalho, calculou-se a margem líquida como sendo a razão entre o lucro líquido dos últimos 12 meses e a receita líquida dos últimos 12 meses.

#### Retorno sobre o Patrimônio Líquido (ROE)

Segundo Kobori (2018), o ROE é um indicador de rentabilidade do dinheiro investido pelos acionistas da empresa e representa o quanto de lucro a empresa gera para cada R$ 100,00 investidos pelos acionistas. Por exemplo, uma empresa com um ROE de 20% é capaz de gerar R$ 20,00 de lucro para cada R$ 100,00 de recursos provenientes do patrimônio líquido.

Portanto, ele é um importante indicador de rentabilidade para avaliar a eficiência da empresa na utilização de seus recursos próprios. Um ROE elevado sugere que a empresa está empregando seus recursos de maneira produtiva, enquanto um ROE baixo sinaliza problemas na gestão financeira do negócio ( STATUS INVEST, 2020). Neste trabalho, o seu cálculo se deu pela razão entre o lucro líquido dos últimos 12 meses e o patrimônio líquido da empresa.

#### Média das variações dos lucros líquidos ($\overline{\Delta LL}$)

Este indicador foi adotado como sendo a métrica de crescimento da empresa, uma vez que ele sugere se, na média, os lucros líquidos da empresa vem crescendo, se encontram estagnadas, ou se vem decrescendo ao longo do tempo.

Neste trabalho, arbitrou-se por calcular a média aritmética das variações dos lucros das empresas nos últimos 5 anos, conforme a seguinte fórmula:

<span id="eq2-26">

$$
\begin{array}{lr}
    \overline{\Delta LL} = \frac{\sum_{t=1}^{5}{{\Delta LL}_{t}}}{5} = \frac{\sum_{t=1}^{5}{\frac{LL_t}{LL_{t-1}}-1}}{5} & \text{(2.26)}
\end{array}
$$

</span>

#### Dívida Líquida / Patrimônio Líquido (DL/PL)

A razão entre dívida líquida (DL) e patrimônio líquido (PL) é um indicador de endividamento que mostra se o patrimônio líquido da empresa será capaz de cobrir o valor das dívidas em caso de falência (STATUS INVEST, 2020).

Por isso, quanto menor o DL/PL, maior é a indicação de boa saúde financeira da empresa, inclusive quando a dívida líquida é negativa, pois indica que a empresa terá dinheiro sobrando em caixa mesmo após o pagamento de toda sua dívida bruta. Consequentemente, quanto maior este indicador maior é a sua alavancagem e o seu risco.

#### DL/EBIT

A razão entre a dívida líquida e o EBIT dos últimos 12 meses é um indicador de endividamento que representa a quantidade de anos que a empresa levará para pagar toda sua dívida líquida a partir do seu lucro operacional, caso o EBIT permaneça constante (STATUS INVEST, 2021). Logo, uma empresa que tenha DL/EBIT = 3, por exemplo, levará 3 anos para que o lucro operacional pague toda a sua dívida líquida, caso esse lucro permaneça constante ao longo desses 3 anos. Por conta disso, entende-se que menor será o risco para o investidor quanto menor for o DL/EBIT da empresa.

#### Índice de Basileia

Utilizado neste trabalho apenas para analisar a solvência dos bancos, o Índice de Basileia informa o quanto um banco possui de capital própria para cada unidade monetária de capital de terceiros (captações) exposto a risco por meio da carteira de crédito. Por exemplo, se um banco possui Índice de Basiléia de 20%, significa que, para cada R$ 1,00 emprestados, o banco possui patrimônio de R$ 0,20 ( BANCO DATA, 2024).

Ou seja, quanto maior o Índice de Basileia de um banco, maior é a capacidade do banco de saldar as suas dívidas. No Brasil, o índice mínimo exigido pelo Banco Central é 11% (BANCO DATA, 2024).

#### Índice de Imobilização

Utilizado neste trabalho apenas para medir o nível de ativo imobilizado dos bancos, este índice mede o nível de liquidez de um banco para conseguir honrar seus compromissos e indica a proporção de ativos que estão imobilizados. Por exemplo, se um banco possui Índice de Imobilização de 30%, significa que, a cada R$ 100,00 em seu patrimônio, R$ 30,00 estarão investidos em bens que não possuem uma liquidez imediata, ou seja, imobilizado em imóveis, veículos, materiais, etc. (BANCO DATA, 2024).

Portanto, quanto mneor for o Índice de Imobilização, maior a capacidade do banco de financiar suas dívidas a partir de seu patrimônio. O índice máximo tolerado pelo Banco Central do Brasil é 50% (BANCO DATA, 2024).

#### Índice de Liquidez Corrente (ILC)

Segundo Kobori (2018), o ILC indica a quantidade de reais que uma empresa tem em disponibilidade no curto prazo para cada R$ 1,00 de dívidas no curto prazo. Ele é calculado a partir da razão entre o ativo e o passivo circulantes e representa a capacidade de pagamento das dívidas de curto prazo com os ativos recebíveis no curto prazo.

Caso o ILC seja menor do que 1, significa que a empresa é dependente de geração de caixa para cumprir as suas obrigações de curto prazo, podendo ser necessário em algumas vender parte do seu ativo não circulante para financiar o seu passivo circulante. Portanto, entende-se que quanto maior a liquidez corrente, menor o risco de inadimplemento no curto prazo.

#### Índice de Liquidez Geral (ILG)

Parecido com o ILC, o ILG avalia todos os ativos liquidáveis da empresa frente a todos os seus passivos, sendo calculado pela razão entre a soma do ativo circulante e recebível a longo prazo e o passivo circulante e exigível a longo prazo ( KOBORI, 2018). Portanto, o ILG mede a capacidade de a empresa pagar a sua dívida bruta a partir dos seus ativos liquidáveis.

Como será explicado em um tópico posterior, o ILG foi empregado neste trabalho apenas para medir a liquidez dos bancos.

### **Apoio Multicritério para Tomada de Decisão (DCMD)**

Os métodos multicritério geralmente auxiliam na tomada de decisão de cenários em há várias alternativas a serem consideradas, com cada uma possuindo vários critérios a serem determinados, ponderados e analisados, objetiva ou subjetivamente, pelo tomador de decisão.

Dentre os principais métodos de apoio multicritério para tomada de decisão, o mais referenciado é o AHP, proposto por Saaty (1994), que leva em consideração a definição de uma hierarquia entre os diferentes critérios por parte do tomador de decisão a partir do seu julgamento sobre a importância relativa entre cada um dos critérios.

Diversos métodos multicritérios foram desenvolvidos para atender a uma variedade de necessidades, cada um aplicando lógicas e funcionalidades distintas. Para este estudo, optou-se por empregar o método TOPSIS, com o intuito de utilizar indicadores fundamentalistas como critérios para classificar as ações segundo à sua similaridade com as soluções ideal e anti-ideal de seus respectivos setores.

#### TOPSIS

O método multicritério TOPSIS, introduzido por Hwang e Yoon (1981), é um procedimento de classificação de alternativas com base em sua proximidade à solução ideal positiva (PIS) e à solução ideal negativa (NIS), também conhecidas respectivamente por soluções ideal e anti-ideal. PIS e NIS representam vetores formados pelas melhores e piores pontuações em cada critério, respectivamente. Portanto, não se referem a alternativas reais presentes na matriz decisão, mas a dois pontos de referência fictícios que são utilizados para calcular as distâncias euclidianas entre esses pontos e cada uma das alternativas.

Para a execução do algoritmo do TOPSIS, é necessário que o tomador de decisão inventarie um conjunto de alternativas $A = [A_1, \dots, A_n]$ com cada um de seus critérios $C=[C_1, \dots, C_m]$ quantificados segundo a sua utilidade $U(C)$ e com seus pesos definidos por $w = [w_1, \dots, w_m]$. Desta forma, obtém-se a matriz de decisão $D_{n \times m}$, composta por valores $v_{ij} = U(C)$, com $i \in \{1, \dots, n\}$ e $j \in \{1, \dots, m\}$.

<span id="eq2-26">

$$
\begin{array}{lr}
    D_{n \times m} =
    \begin{matrix}
        \ & \begin{matrix} C_1 & C_2 & \dots & C_m\end{matrix} \\
        \begin{matrix}A_1 \\ A_2 \\ \vdots \\ A_n\end{matrix} &
        \begin{bmatrix}
            v_{11} & v_{12} & \dots  & v_{1m} \\
            v_{21} & v_{22} & \dots  & v_{2m} \\
            \vdots & \vdots & \ddots & \vdots \\
            v_{n1} & v_{n2} & \dots  & v_{nm}
        \end{bmatrix}
    \end{matrix} & \text{(2.27)}
\end{array}
$$

</span>

Além disso, o tomador de decisão deve ainda estabelecer um vetor de impactos $I = [I_1, I_2, \dots, I_m]$ para cada um dos $m$ critérios, caso estes não tenham sido considerados nas respectivas funções de utilidade. Se um critério é considerado melhor quando seu valor aumenta, então $I_j = +1$. Caso ele seja pior quanto maior o seu valor, então $I_j = -1$.

Uma das maneiras de se interpretar o impacto $I_j$ de um critério $C_j$ é considerá-lo como sendo o sinal algébrico da primeira derivada da função utilidade $U_j:C_j \in \mathbb{R} \rightarrow \mathbb{R}$ ao longo de todo o seu domínio. Por esse motivo, essa interpretação do impacto $I_j$ só será válido se a função utilidade para o critério $C_j$ for monotônico, isto é, se ele for estritamente crescente ou estritamente decrescente em todo o seu domínio, para que o sinal da primeira derivada de $U_j$ seja o mesmo em todo o seu domínio.

Um exemplo ilustrativo que ressalta a complexidade na definição de impacto para um critério é o que ocorre com o indicador P/L. No caso de P/L > 0, seu impacto é negativo, já que quanto menor o P/L de uma ação, mais atrativa ela se torna para investimento, pois significa que ela está mais barata. No entanto, essa interpretação muda quando P/L < 0, indicando que a empresa apresentou prejuízo nos últimos 12 meses, tornando o indicador tão indesejável quanto menor for o seu valor. Em resumo, a utilidade do indicador P/L não é monotônica, visto que exibe impacto negativo no intervalo $(0, +\infty)$ e impacto positivo em $(-\infty, 0)$.

Uma maneira de contornar essa situação é limitar o domínio da função utilidade para um intervalo em que a função é monotônica. Considerar apenas as ações com P/L > 0 para compor o conjunto de alternativas da matriz de decisão é um exemplo disso. Outra maneira seria redefinir a função utilidade de forma que ela passe a ser monotônica. Por exemplo, não considerar o P/L, mas sim o seu inverso, L/P (lucro dos últimos 12 meses por ação dividido pelo preço da ação), é uma alternativa para isso, já que criar-se-ia um indicador com impacto positivo em todo o conjunto dos números reais. Como será visto na metodologia, a inversão dos indicadores P/L e P/VP serão arbitrados pelo autor para a compor os seus $U(C)$ antes de aplicar o TOPSIS.

Após a definição da matriz $D_{n \times m}$, os pesos são normalizados conforme a equação a seguir:

<span id="eq2-28">

$$
\begin{array}{lr}
    \overline{w}_j = \frac{w_j}{\sum_{j=1}^{m}{w_j}} & \text{(2.28)}
\end{array}
$$

</span>

Com o vetor de pesos normalizados $ \overline{w}_j = [ \overline{w}_1,  \overline{w}_2, \dots, \overline{w}_m]$ calculados, os valores da matriz $D_{n \times m}$ serão normalizados pela fórmula:

<span id="eq2-29">

$$
\begin{array}{lr}
    \overline{v}_{ij} = \frac{I_jv_{ij}}{\sqrt{\sum_{i=1}^{n}{v^{2}_{ij}}}} & \text{(2.29)}
\end{array}
$$

</span>

Obtendo, assim, a matriz de decisão normalizada .

<span id="eq2-30">

$$
\begin{array}{lr}
    \overline{D}_{n \times m} =
    \begin{matrix}
        \ & \begin{matrix} C_1 & \dots & C_j & \dots & C_m\end{matrix} \\
        \begin{matrix}A_1 \\ \vdots \\ A_i \\ \vdots \\ A_n\end{matrix} &
        \begin{bmatrix}
            \overline{v}_{11} & \dots & \overline{v}_{1j} & \dots  & \overline{v}_{1m} \\
            \vdots & \ddots & \vdots & \ddots & \vdots \\
            \overline{v}_{i1} & \dots & \overline{v}_{ij} & \dots  & \overline{v}_{im} \\
            \vdots & \ddots & \vdots & \ddots & \vdots \\
            \overline{v}_{n1} & \dots & \overline{v}_{nj} & \dots  & \overline{v}_{nm}
        \end{bmatrix}
    \end{matrix} & \text{(2.30)}
\end{array}
$$

</span>

A partir de $\overline{D}_{n \times m}$, serão obtidos os vetores das soluções ideal (PIS) e anti-ideal (NIS) a partir dos valores máximos e mínimos presentes em cada um dos critérios $C_j$.

<span id="eq2-31">

$$
\begin{array}{lr}
    PIS = [\text{Max}_j\{\overline{v}_{ij}\}| \forall j \in \{1, \dots, m\}] = [\overline{v}_{1}^{+}, \dots, \overline{v}_{j}^{+}, \dots, \overline{v}_{m}^{+}] & \text{(2.31)}
\end{array}
$$

</span>

<span id="eq2-32">

$$
\begin{array}{lr}
    NIS = [\text{Min}_j\{\overline{v}_{ij}\}| \forall j \in \{1, \dots, m\}] = [\overline{v}_{1}^{-}, \dots, \overline{v}_{j}^{-}, \dots, \overline{v}_{m}^{-}] & \text{(2.32)}
\end{array}
$$

</span>

Usando PIS e NIS como referências, calcula-se as distâncias euclidianas até a solução ideal ($d_{i}^{+}$) e a anti-ideal ($d_{i}^{-}$) para cada uma das alternativas $A_i$.

<span id="eq2-33">

$$
\begin{array}{lr}
    d_{i}^{+} = \sqrt{\sum_{j=1}^{m}{(\overline{v}_{ij} - \overline{v}_{j}^{+})^2}} & \text{(2.33)}
\end{array}
$$

</span>

<span id="eq2-34">

$$
\begin{array}{lr}
    d_{i}^{-} = \sqrt{\sum_{j=1}^{m}{(\overline{v}_{ij} - \overline{v}_{j}^{-})^2}} & \text{(2.34)}
\end{array}
$$

</span>

Finalmente, calcula-se o coeficiente de similaridade ${CC}_{i}$ para cada uma das alternativas $A_i$, a fim de que elas sejam ordenadas em ordem decrescente de ${CC}_{i}$.

<span id="eq2-35">

$$
\begin{array}{lr}
    {CC}_{i} = \frac{d_{i}^{-}}{d_{i}^{-}+d_{i}^{+}} & \text{(2.35)}
\end{array}
$$

</span>

#### Método da Entropia

Para a execução do método TOPSIS, exige-se que os pesos dos critérios sejam definidos pelo tomador de decisão, o que pode acabar sendo um processo dispendioso em decisões que envolvam uma vasta quantidade critérios ou que exijam o conhecimento de especialistas para a sua devida ponderação.

Como alternativa para a definição dos pesos sem a necessidade da intervenção do tomador de decisão ou de consultas especializadas na área de investimentos ou de avaliação de ações, adotou-se para este trabalho o método da entropia, que servirá para mensurar a importância informacional oferecida por um critério em uma tomada de decisão (HEIN at al., 2013).

Conforme explicado no trabalho de Hein _et al_. (2013), o conceito de entropia foi definido pelo físico Rudolf Clausius em 1865 como medida do grau de irreversibilidade de um sistema termodinâmico fechado. Em 1948, esse conceito foi ampliado para a área da Teoria da Informação, fundada por Claude Shannon, quem redefiniu a entropia para uma variável aleatória discreta como sendo:

<span id="eq2-36">

$$
\begin{array}{lr}
    S[X] = -\sum_{i=1}^{n}{p_i(x)\ln (p_i(x))} & \text{(2.36)}
\end{array}
$$

</span>

Onde $0 \le p_i(x) \le 1$ é a probabilidade de $X=i$.

Por convenção, caso $p_i(x) = 0$ para algum valor $i$, então teremos que $p_i(x)\text{ln}(p_i(x)) = 0$. De fato, esse é o valor para qual a expressão converge quando $p$ tende a 0, como demonstrado a seguir:

$$ \lim_{p \to 0^{+}}{p \ln p} = \lim_{p \to 0^{+}}{\frac{\ln p}{1/p}} = -\frac{\infty}{\infty} \therefore \lim_{p \to 0^{+}}{\frac{\ln p}{1/p}} = \lim_{p \to 0^{+}}{\frac{\frac{d}{dp}(\ln p)}{\frac{d}{dp}(1/p)}} = \lim_{p \to 0^{+}}{\frac{1/p}{-1/p^2}} = \lim_{p \to 0^{+}}{-p} = 0$$

Já no caso de uma variável aleatória contínua, com função de distribuição de probabilidade $p(x)$, a sua entropia é definida por:

<span id="eq2-37">

$$
\begin{array}{lr}
    S[X] = -\int_{0}^{\infty}{p_i(x) \ln (p_i(x))} & \text{(2.37)}
\end{array}
$$

</span>

Conforme explicado por Hein _et al_. (2013), quanto maior for a diferenciação dos valores de um dado atributo (isto é, quanto menor for a sua entropia), maior é o seu poder informacional para a determinação de uma decisão. Para ser mais ilustrativo, em um exemplo de tomada de decisão da compra de uma casa, em que o preço de todas as casas é o mesmo, tratar-se-ia de um critério com o mais alto grau de entropia, pois o preço da moradia não informa nenhuma discriminação entre as alternativas que possibilite ao tomador de decisão escolher a melhor casa. Nesses casos, o critério “preço” teria a máxima entropia e seria descartada da matriz de decisão.

O processo para a determinação dos pesos $w_j$ pelo método da entropia, conforme apresentado por Hein _et al_. (2013), se inicia com a normalização dos valores da matriz de decisão $D_{n \times m}$ em relação a cada um dos critérios $C_j$ por:

<span id="eq2-38">

$$
\begin{array}{lr}
    \overline{v}_{ij} = \frac{v_{ij}}{\text{Max}_j\{v_{ij}\}} & \text{(2.38)}
\end{array}
$$

</span>

No entanto, vale salientar que a fórmula 2.38 só é aplicável quando todos os respectivos $v_{ij}$ a um critério $C_j$ são positivos. No caso de haver alguns $v_{ij} \le 0$, a normalização de $D_{n \times m}$ deve ser feita de forma a torna todos os valores $v_{ij}$ em números positivos, uma vez que o cálculo da entropia de um critério envolve o uso da função logarítmica, cujo domínio corresponde ao conjunto dos números reais positivos. Portanto, nesta etapa, adotou-se a seguinte Normalização Min-Máx para que os valores $v_{ij}$ fossem reescalados para o intervalo $(0, 1]$.

<span id="eq2-39">

$$
\begin{array}{lr}
    \overline{v}_{ij} = \frac{v_{ij} - \text{Min}_j\{v_{ij}\}}{\text{Max}_j\{v_{ij}\} - \text{Min}_j\{v_{ij}\}} & \text{(2.39)}
\end{array}
$$

</span>

Com os dados normalizados, calcula-se a entropia $s_j$ do critério $j$ como sendo:

<span id="eq2-40">

$$
\begin{array}{lr}
    s_j = -\frac{1}{s_{\text{Max}}} \sum_{i=1}^{n}{\frac{\overline{v}_{ij}}{V_j} \ln (\frac{\overline{v}_{ij}}{V_j})} & \text{(2.40)}
\end{array}
$$

</span>

Onde:

- $s_{\text{Max}} = \ln(n)$ é a entropia máxima que um critério pode alcançar;
- $V_j = \sum_{i=1}^{n}{\overline{v}_{ij}}$ corresponde ao somatório de todos os valores normalizados do critério $j$.

Como explicado anteriormente, quanto maior a entropia $s_j$ menor será o poder informacional do critério $j$. Assim, o seu peso final $\lambda_j$ deverá ser proporcional a $1-s_j$, e não a $s_j$, e normalizado para assegurar que $0 \le \lambda_j \le 1$ e que $\sum_{j=1}^{m}{\lambda_j} = 1$ (HEIN _et al_., 2013). Portanto, o seu cálculo deverá ser dado por:

<span id="eq2-41">

$$
\begin{array}{lr}
    \lambda_j = \frac{1-s_j}{m-S} & \text{(2.41)}
\end{array}
$$

</span>

Onde $S=\sum_{j=1}^{m}{s_j}$ é o somatório das entropias de todos os critérios.

Vale lembrar que, como exemplificado anteriormente, no caso de todos os valores $v_{ij}$ para um dado critério $j$ sejam iguais entre si, então a sua entropia será igual a:

$$ s_j = -\frac{1}{\ln(n)} \sum_{i=1}^{n}{\frac{1}{n}\ln(\frac{1}{n})} = -\frac{1}{\ln(n)}n (\frac{1}{n}\ln(\frac{1}{n})) = \frac{\ln(n)}{\ln(n)} = 1$$

Isto é, o critério alcançará a entropia máxima e, portanto, deverá ser retirada do modelo, já que em nada contribui na discriminação das alternativas, e os $\lambda_j$ deverão ser recalculados.

Dessa forma, os pesos finais dos critérios no método TOPSIS serão dados por $\overline{w}_{j} = \lambda_j$, como foi o caso deste trabalho. Não obstante, no caso de o tomador de decisão ainda quiser desempenhar o papel de atribuir os pesos subjetivos $w_{j}$, Hein _et al_. (2013) sugerem combiná-los e normalizá-los com os $\lambda_j$ obtidos do método da entropia pela seguinte normalização:

<span id="eq2-42">

$$
\begin{array}{lr}
    \overline{w}_{j} = \frac{w_j\lambda_j}{\sum_{j=1}^{m}{w_j\lambda_j}} & \text{(2.42)}
\end{array}
$$

</span>

### **Power Query**

O Power Query é um mecanismo de transformação e preparação de dados criado pela Microsoft Corporation. Ele vem com uma interface gráfica para obter dados de fontes e um Editor do Power Query para aplicar transformações. Ele permite que o usuário escreva e execute processamentos ETL (extrair, transformar e carregar) com os dados ( MICROSOFT, 2024). Com o Power Query, é possível extrais informações das mais diversas fontes, sem a necessidade de instalar pacotes, bibliotecas ou programas adicionais. Toda a execução do ETL é feito por meio de um script em código Mashup (M Code) e por meio de funções nativas que permitem a edição, transformação, conversão, exclusão, reestruturação, cálculo e carregamento de dados.

Neste trabalho, os modelos, os cálculos e as simulações foram criadas no Power Query do Excel.

# **METODOLOGIA**

A metodologia adotada para este trabalho envolve as etapas do processo do CRISP-DM (CHAPMAN _et al._, 2000), um dos comumente empregados em projetos de Ciência de Dados por considerar um projeto de _Data Mining_ com um ciclo de vida flexível, havendo possibilidades de idas e voltas entre as fases para constante revisão e aprimoramento dos objetivos, do escopo, dos procedimentos e do modelo adotado antes da sua implementação. Além disso, como indicado pela Figura 1, considera-se que o projeto não se finaliza completamente após a sua implementação, podendo sempre haver projetos subsequentes, mais aperfeiçoados e mais direcionada a atender os objetivos do negócio por se basear nas lições aprendidas dos ciclos antecessores.

|<span id="figure1">Figura 1</span> – Fases do modelo CRISP-DM|
|:---:|
|![Figura 1](https://cdn.jsdelivr.net/gh/rodrigo-cl-porto/Valuation-DFC-TOPSIS-Entropia/docs/assets/figure1.png)|
|Fonte: CHAPMAN, 2000|

Como apresentado pela [Figura 1](#figure1), o CRISP-DM é constituído por seis fases, os quais serão explicadas a seguir, junto com os detalhamentos deste trabalho.

## **COMPREENSÃO DO NEGÓCIO**

Como descrito por Chapman _et al_. (2000), a etapa inicial concentra-se na definição dos objetivos e requisitos do projeto a partir de uma perspectiva de negócios a fim de definir o processo de mineração de dados e as técnicas de modelagem necessárias para o cumprimento desses objetivos.

Como uma adaptação desta fase inicial do CRISP-DM ao escopo do presente estudo, a “perspectiva de negócio” a ser considerada seria a análise de investimento em ações no Brasil. No nicho dos investimentos, sabe-se que a decisão de investir em um ativo é fundamentada em três pilares: segurança, rentabilidade e liquidez (ANBIMA, 2023).

Rentabilidade está relacionado ao retorno auferido pelo ativo.

Segurança, ao encontro da expectativa esperada de retorno. Quanto menor for a volatilidade de um ativo, menos arriscado ele é.

A liquidez, por sua vez, se refere à facilidade com que um ativo pode ser transformar em dinheiro, sem resultar em prejuízo na sua liquidação.

Apesar da rentabilidade de um ativo ser considerado por muitos o aspecto mais importante, a negligência aos outros dois poderá acarretar em frustrações e prejuízos aos investidores, ainda mais quando a avaliação do tripé de um ativo não corresponde bem ao perfil do investidor ou à necessidade de alocação da quantia investida. Geralmente é com base nesse tripé que os investidores tomam suas decisões, para atender a suas expectativas e objetivos, dentro da sua tolerância ao risco (ANBIMA, 2023).

Uma qualidade notável do clássico tripé é o fato de sempre haver um _trade-off_ quando há uma preferência para um ou dois dos objetivos. Isto é, nunca será possível encontrar um investimento que seja, ao mesmo tempo, altamente rentável, livre de risco e cujo valor (principal mais os juros) possa ser resgatado a qualquer instante por qualquer quantia sem realizar prejuízo. Uma forma bem didática de ilustrar esse custo de compensação é representar o tripé por meio de um triângulo (Figura 2): quanto mais nos aproximarmos de um dos seus vértices, mais nos afastamos dos outros dois.

|<span id="figure2">Figura 2</span> – Tripé do investidor|
|:---:|
|![Figura 2](https://cdn.jsdelivr.net/gh/rodrigo-cl-porto/Valuation-DFC-TOPSIS-Entropia/docs/assets/figure2.png)|
|Fonte: Elaboração própria|

Porém, nada impede de um investidor inserir outros objetivos para a escolha de ações, tais como a eficiência financeira e operacional dos negócios, a sua sustentabilidade, a preocupação da empresa com questões ambientais e sociais, ter boa governança corporativa e bom relacionamento com os _stakeholders_ etc.

Como objetivos para a escolha de uma ação, foi adotado uma postura conservadora, assumindo que o tomador de decisão seja um investidor mais preocupado em não correr tanto risco no mercado do que em auferir grandes retornos em períodos de curto e médio prazo, porque visa aproveitar grandes movimentações no longo e no longuíssimo prazo.

A partir desta premissa, foi elaborado a [Tabela 5](#table5), que reúne os valores e objetivos pretendidos pela avaliação das ações disponíveis no mercado.

<table id="table5">
    <caption style="text-align:center;"><strong>Tabela 5 – Objetivos e valores do investidor conservador</strong></caption>
    <thead>
        <tr>
            <th style="text-align:center">OBJETIVOS</th>
            <th style="text-align:center">VALORES</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td style="text-align:center">Liquidez</td>
            <td>
                <ul>
                    <li>Ter o poder de comprar e vender as ações sem precisar se preocupar em ter que comprá-las caras demais ou vendê-las baratas demais só para conseguir comprar ou vender.</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td style="text-align:center">Rentabilidade</td>
            <td>
                <ul>
                    <li>Adquirir ações de boas empresas que estejam subprecificadas e vendê-las quando estiverem sobreprecificadas;</li>
                    <li>Comprar ações de empresas que tenham alta eficiência financeira, alto <em>payout</em> e que seja boa pagadora de dividendos;</li>
                    <li>Buscar por empresas que apresentaram lucros líquidos crescentes nos últimos anos.</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td style="text-align:center">Segurança</td>
            <td>
                <ul>
                    <li>Investir em empresas sólidas e que possuam bons fundamentos para não haver preocupações constantes, surpresas desagradáveis e futuros arrependimentos;</li>
                    <li>Preferir aproveitar grandes movimentações no longo prazo a correr o risco de perdas significativas do patrimônio no curto prazo</li>
                    <li>Não concentrar demais a carteira a ponto de não diluir o risco específico suficientemente bem, porém tampouco diversificá-lo demais para não elevar o custo de oportunidade e pulverizar o seu potencial de rentabilidade</li>
                    <li>Uma vez ciente de que os investimentos em ações foram boas, aceita-se perdas momentâneas no curto e no médio prazo.</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td style="text-align:center">Endividamento</td>
            <td>
                <ul>
                    <li>Investir em empresas que possuam uma dívida saudável e controlada;</li>
                    <li>Investir em empresas que tenham caixa e disponibilidades suficientes para cobrir seu passivo circulante;</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td style="text-align:center">Sustentabilidade</td>
            <td>
                <ul>
                    <li>Preferir empresas com fundamentos sólidos e boa saúde financeira do que empresas rentáveis, porém altamente alavancadas;</li>
                </ul>
            </td>
        </tr>
    </tbody>
    <tfoot>
        <tr>
            <td style="text-align:center" colspan="2">Fonte: Elaboração própria</td>
        </tr>
    </tfoot>
</table>

## **COMPREENSÃO DOS DADOS**

Após a análise do contexto de negócio, procura-se identificar os conjuntos de dados necessários para atender aos objetivos estabelecidos, determinar em quais fontes esses dados estão disponíveis para a sua coleta inicial (CHAPMAN _et al_., 2000).

A [Tabela 6](#table6) resume as principais informações consideradas necessárias para o processo de _valuation_ proposto neste trabalho e as fontes das quais elas foram obtidas. Como optou-se por formular um modelo de FCD com fluxos de caixas reais, era necessário obter as taxas de inflação – tendo arbitrado o IPCA como o indicador dessa variável macroeconômica – para serem descontadas das taxas nominais. Por conta disso, não foram consideradas a aplicação das tributações na avaliação das rentabilidades das carteiras selecionadas ou sobre a Selic, uma vez que a base de cálculo do IR é a rentabilidade nominal, e não a real.

<table id="table6">
    <caption style="text-align:center;"><strong>Tabela 6 – Conjunto de dados utilizados</strong></caption>
    <thead>
        <tr>
            <th style="text-align:center">Dado</th>
            <th style="text-align:center">Fonte</th>
            <th style="text-align:center">Descrição</th>
            <th style="text-align:center">Período</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>IPCA – Mensal SGS</td>
            <td>Percentuais mensais da inflação.</td>
            <td>Últimos 30 anos a partir do ano de referência (intervalo de tempo arbitrado pelo autor).</td>
            <td>Liquidez</td>
        </tr>
        <tr>
            <td>IPCA – Anual</td>
            <td>ISGS</td>
            <td>Percentuais anuais da inflação (calculados a partir das variações mensais do IPCA)</td>
            <td>Últimos 30 anos a partir do ano de referência (intervalo de tempo arbitrado pelo autor).</td>
        </tr>
        <tr>
            <td>Ibovespa</td>
            <td>Ipeadata</td>
            <td>Retornos mensais reais da carteira teórica do Ibovespa (calculados descontando as variações mensais do IPCA).</td>
            <td>Últimos 30 anos a partir do ano de referência (intervalo de tempo arbitrado pelo autor).</td>
        </tr>
        <tr>
            <td>PIB</td>
            <td>Ipeadata</td>
            <td>Retornos anuais reais do PIB brasileiro (obtidos diretamente da fonte)</td>
            <td>Últimos 100 anos a partir do ano de referência (intervalo de tempo arbitrado pelo autor).</td>
        </tr>
        <tr>
            <td>Taxa Selic</td>
            <td>SGS</td>
            <td>Taxas mensais reais da Selic no ano de referência. (Calculados retirando as inflações mensais da Taxa Selic nominal).</td>
            <td>Os 12 meses do ano de referência (intervalo de tempo arbitrado pelo autor).</td>
        </tr>
        <tr>
            <td>Balanços Patrimoniais (BPs)</td>
            <td>Sistemas CVM</td>
            <td>Obtidos das Demonstrações Financeiras Padronizadas (DFP) do Portal de Dados Abertos da CVM.</td>
            <td>Últimos 5 anos a partir do ano de referência (intervalo de tempo arbitrado pelo autor).</td>
        </tr>
        <tr>
            <td>Demonstrações de Fluxo de Caixa (DFCs)</td>
            <td>Sistemas CVM</td>
            <td>Obtidos das DFPs do Portal de Dados Abertos da CVM.</td>
            <td>Últimos 5 anos a partir do ano de referência (intervalo de tempo arbitrado pelo autor).</td>
        </tr>
        <tr>
            <td>Demonstrações de Resultado de Exercício (DRE)</td>
            <td>Sistemas CVM</td>
            <td>Obtidos das DFPs do Portal de Dados Abertos da CVM.</td>
            <td>Últimos 5 anos a partir do ano de referência (intervalo de tempo arbitrado pelo autor).</td>
        </tr>
        <tr>
            <td>Cotações e retornos históricos das ações</td>
            <td>Yahoo! Finance</td>
            <td>Retornos percentuais mensais das ações baseados nas variações das cotações entre o último dia de um mês e o do seu anterior.</td>
            <td>Últimos 5 anos a partir do ano de referência (intervalo de tempo arbitrado pelo autor).</td>
        </tr>
        <tr>
            <td>Lista das empresas cadastradas na CVM</td>
            <td>Sistemas CVM</td>
            <td>Obtida dos Formulários de Referência (FRE) do Portal de Dados Abertos da CVM.</td>
            <td>Últimos 5 anos a partir do ano de referência (intervalo de tempo arbitrado pelo autor).</td>
        </tr>
        <tr>
            <td>Capital social as empresas</td>
            <td>Sistemas CVM</td>
            <td>Obtida dos FREs do Portal de Dados Abertos da CVM.</td>
            <td>Últimos 5 anos a partir do ano de referência (intervalo de tempo arbitrado pelo autor).</td>
        </tr>
        <tr>
            <td>Lista das instituições financeiras</td>
            <td>IFData</td>
            <td>Informações sobre as instituições financeiras independentes e conglomerados prudenciais que compõem os relatórios disponíveis no IFData.</td>
            <td>Dados de dezembro do ano de referência.</td>
        </tr>
        <tr>
            <td>Indicadores de endividamento das instituições financeiras</td>
            <td>IFData</td>
            <td>Índice de Basileia e de Imobilização das instituições financeiras independentes e conglomerados prudenciais.</td>
            <td>Dados de dezembro do de referência.</td>
        </tr>
        <tr>
            <td>Indicadores fundamentalistas</td>
            <td>Demonstrativos contábeis das empresas (BPs, DREs e DFCs)</td>
            <td>Calculados a partir dos demonstrativos contábeis das empresas negociadas na B3.</td>
            <td>Dados de dezembro do de referência.</td>
        </tr>
    </tbody>
    <tfoot>
        <tr>
            <td style="text-align:center" colspan="4">Fonte: Elaboração própria</td>
        </tr>
    </tfoot>
</table>

Com os dados adquiridos, busca-se uma compreensão aprofundada para extrair os primeiros _insights_ e formular hipóteses sobre os potenciais informações e conhecimentos a serem extraídos do conjunto de dados. Além disso, realiza-se uma avaliação criteriosa, identificando possíveis problemas de qualidade dos dados, como dados faltantes, _outliers_, escalas inadequadas e medidas inconsistentes, corrigindo-os na fase subsequente do projeto.

Dentre as principais inconsistências percebidas ao extrair as informações descritas na [Tabela 6](#table6) estava a ausência de ajuste dos preços de fechamento das cotações hisóricas das ações. Inicialmente, as cotações estavam sendo extraídas dos dados da B3 a fim de calcular os retornos mensais históricos das ações, os quais serão necessários para calcular os seus $\beta_i$ e, por conseguinte, o custo de capital próprio $r_E$. No entanto, ao calculá-los, percebeu-se que as cotações de fechamento das ações não estavam devidamente ajustadas segundo fatos societários que acarretam na mudança do preço teórico da ação, tais como desdobramentos, agrupamentos, subscrições, bonificações e distribuição de dividendos, o que resultava em distorções nos seus retornos.

Por exemplo, uma ação que estava sendo negociado por R$ 100,00 e sofresse um desdobramento 1:2 (1 ação se divide em 2) deve ter os seu preço de fechamento teórico ajustado para R$ 50,00. Portanto, caso no dia logo após esse desdobramento o seu preço feche por R$ 52,00, a variação daquele dia deve ser de $\frac{52}{50}-1=4\text{\%}$. No entanto, como os fechamentos da B3 não estavam ajustados, a mesma ação teria o retorno daquele dia calculado como $\frac{52}{100}-1 = -48\text{\%}$, o que é incorreto. Por conta disso, viu-se que as séries históricas fornecidas pela B3 não seriam adequadas e necessitou-se de uma outra fonte de dados que fornecesse os preços de fechamento ajustados para o cálculo adequado dos retornos, sendo a melhor opção encontrada o Yahoo! Finance. Apenas por questão de conveniência, apenas os tickers cujas cotações históricas foram encontradas no Yahoo! Finance para mais da metade do período histórico considerado comporam a amostra para a proposta do modelo de _valuation_.

Uma outra inconsistência percebida foi a existência de incorreções nos valores dos capitais sociais das empresas nos FREs disponibilizados pela CVM, cujos valores não correspondiam ao seu valor de mercado negociado no último dia do ano. Também foi visto que a quantidade de ações para alguns tickers se diferia da quantidade de papéis que de fato compunham o seu capital social em alguns anos, mesmo não havendo fatos sociais que justificassem essa divergência (agrupamentos, desdobramentos, bonificações, subscrições etc.). Houve até mesmo registros em que constavam uma quantidade nula de papéis, tanto para ações ordinárias quanto para as preferenciais, mesmo quando constava um capital social não nulo. Apesar da ocorrência de inconsisências na quantidade de papéis ter sido rara, foi arbitrado que os valores de capitais sociais a serem consideradas seria o seu próprio valor de mercado, resultado do produto entre o preço de fechamento ajustado do último dia do ano e o número de ações. No caso de a quantidade de ações estiver zerada mesmo quando o capital social não fosse nulo, então utilizava-se o próprio capital social constado na FRE, uma vez que não seria possível calcular o seu valor de mercado.

Uma terceira relevante inconsistência deparada ao longo da criação do processo de extração dos dados foi a diferença na estruturação das contas patrimoniais nos BPs da CVM, entre os bancos e o restante das empresas. Enquanto os BPs das empresas geralmente separam os ativos e os passivos em circulantes e não circulantes, os BPs dos bancos não possuem essa separação, o que dificultou a distinção entre as contas de curto e longo prazo e impossibilitou o cálculo de um dos indicadores fundamentalistas necessários para a etapa do TOPSIS, o Índice de Liquidez Corrente (ILC), que teve de ser substituída pelo Índice de Liquidez Geral (ILG) para a análise reservada do setor bancário. Por causa dessa e de outras peculiaridades a serem tratadas para a análise de bancos, arbitrou-se por separar os bancos do restante do setor financeiro (holdings, seguradoras, corretoras, intermediadoras imobiliárias etc.), tratando o setor bancário como um setor a parte por si só.

## **PREPARAÇÃO DOS DADOS**

A fase de preparação de dados abrange todas as atividades para construir o conjunto final de dados que será alimentado pela(s) técnica(s) de modelagens adotadas para o projeto (CHAPMAN _et al_., 2000).

É nessa fase em que os processos de ETL mais se destacam, os quais envolvem justamente a extração dos dados brutos a partir das fontes escolhidas na fase anterior, seguidas pelos seu tratamento para a confecção e consolidação dos dados finais, os quais serão armazenados e carregados para dentro dos modelos.

As atividades de tratamento e pré-processamento dos dados envolve a seleção de tabelas, registros e atributos relevantes para o projeto; formatação e reajuste dos dados; exclusão de informações desnecessárias; normalização para escalas adequadas; tratamento de _outliers_, nulos, dados faltantes etc.; tipificação dos dados (definir se um dado é do tipo texto, número, monetário, data, lógico, binário etc.); obtenção de novas informações a partir de ferramentas estatísticas ou da combinação dos dados originais, como cálculo entre colunas, adição de uma coluna a partir de dados existentes, junção ou concatenação de duas ou mais tabelas etc.

O processo ETL escolhido para esta fase se baseou nas seguintes regras de tratamento:

- Dados categóricos faltantes foram preenchidos pela moda;
- Dados quantitativos faltantes foram preenchidos pela mediana e pela média na presença ou na ausência de _outliers_ nos atributos, respectivamente.
- Empresas que apresentarem valor de mercado intrínseco não positivo foram desconsideradas para as avaliações intríseca e comparativa.
- Para empresas que eram negociadas no mercado em mais de um tipo de ação (ordinária e preferencial), foi selecionada apenas a ação com o maior volume de negociações para a sua análise.
- Conversão das taxas nominais para reais por meio do desconto do IPCA anual ou mensal, dependendo da periodicidade da taxa.
- A normalização dos dados não foi necessária nesta fase, uma vez que o TOPSIS já realiza essa tarefa como uma das etapas do seu modelo.
- Para a realização do TOPSIS, alguns indicadores tiveram que ser modificados segundo a sua função de desejabilidade $U(C)$ para que fossem adequadamente aplicados ao método multicritério (por exemplo, multiplicar o critério por um fator de -1 caso o seu aumento representasse um valor indesejável ao tomador de decisão), como estão melhor explicados na [Tabela 7](#table7).

<table id="table7">
    <caption style="text-align:center;"><strong>Tabela 7 – Indicadores fundamentalistas utilizadas no TOPSIS</strong></caption>
    <thead>
        <tr>
            <th style="text-align:center">Critério</th>
            <th style="text-align:center">Descrição</th>
            <th style="text-align:center"><em>U(C)</em></th>
            <th style="text-align:center">Justificativa</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td style="text-align:center">Volume de negociação</td>
            <td>Total do volume de negociação referente a uma ação no mês atual</td>
            <td style="text-align:center">O próprio indicador</td>
            <td>Quanto maior o volume de negocioções de um papel, mais líquidez ele possui, diminuindo o risco de o investidor ter que vender mais barato apenas para se livrar do papel ou de ter que comprar mais caro apenas para conseguir assumir posição.</td>
        </tr>
        <tr>
            <td style="text-align:center">Dividend Yield (DY)</td>
            <td>Somatório dos dividendos por ação distribuídos nos últimos 12 meses dividido pelo preço da ação, ou total de dividendos distribuídos dividido pelo valor de mercado da empresa.</td>
            <td style="text-align:center">O próprio indicador.</td>
            <td>Não houve necessidade de modificação, já que quanto maior o DY, melhor é o indicativo de uma boa empresa pagadora de dividendos.</td>
        </tr>
        <tr>
            <td style="text-align:center">P/L</td>
            <td>Razão entre valor de mercado da empresa e o total de lucros auferidos nos últimos 12 meses.</td>
            <td style="text-align:center">L/P.</td>
            <td>P/L é desejável quanto menor ele for, desde que positivo. Caso contrário, ele passa a ser indesejável. Para tornar a sua função de desejabilidade monótona, arbitrou-se usar o seu inverso, isto é, o L/P, que é melhor quando maior for e vice-versa.</td>
        </tr>
        <tr>
            <td style="text-align:center">P/VP</td>
            <td>Razão entre o valor de mercado da empresa e o seu patrimônio líquido</td>
            <td style="text-align:center">VP/P</td>
            <td>Justificativa análoga a do P/L.</td>
        </tr>
        <tr>
            <td style="text-align:center">DL/PL</td>
            <td>Razão entre a dívida líquida e o patrimônio líquido.</td>
            <td style="text-align:center">-DL/PL</td>
            <td>Quanto menor o DL/PL menor é a alavancagem da empresa e, portanto, menor é a percepção de risco dos acionistas.</td>
        </tr>
        <tr>
            <td style="text-align:center">DL/EBIT</td>
            <td>Razão entre a dívida líquida e o EBIT.</td>
            <td style="text-align:center">-DL/EBIT</td>
            <td>Como o DL/EBIT pode ser interpretado como sendo a quantidade de anos que uma empresa levará para quitar toda a sua dívida líquida a partir do seu resultado operacional. Portanto, quanto menor o seu valor, melhor.</td>
        </tr>
        <tr>
            <td style="text-align:center">Índice de Basileia</td>
            <td>Razão entre o Patrimônio de Referência da instituição financeira e o Ativos Ponderados pelo Risco.</td>
            <td style="text-align:center">O próprio indicador</td>
            <td>Esse indicador mede o nível de solvência de um banco e representa a relação entre o capital próprio e as captações. Quanto maior esse índice, menor é a alvancagem do banco.</td>
        </tr>
        <tr>
            <td style="text-align:center">Índice de Imobilização</td>
            <td>Percentual dos ativos do banco que se encontram imobilizados.</td>
            <td style="text-align:center">-(Índice de Imobilização)</td>
            <td>Quanto menor esse índice, menor é a quantidade de ativos imobilizados no banco e, portanto, maior é a sua liquidez para honrar seus compromissos.</td>
        </tr>
        <tr>
            <td style="text-align:center">Índice de Liquidez Corrente (ILC)</td>
            <td>Razão entre ativo circulantes e passivo circulante.</td>
            <td style="text-align:center">O próprio indicador</td>
            <td>Quanto maior esse indicador, melhor é a liquidez que uma empresa tem para honrar suas obrigações de curto prazo.</td>
        </tr>
        <tr>
            <td style="text-align:center">Índice de Liquidez Geral (ILG)</td>
            <td>Razão entre o total de ativos e o total capital de terceiros</td>
            <td style="text-align:center">O próprio indicador</td>
            <td>Quanto maior esse indicador, maior é a capacidade de a empresa pagar todo o seu capital de terceiros com seus ativos liquidáveis.</td>
        </tr>
        <tr>
            <td style="text-align:center">Margem Líquida</td>
            <td>Razão entre o lucro líquido (LL) e a receita líquida (RL).</td>
            <td style="text-align:center">O próprio indicador</td>
            <td>Quanto maior a margem líquida, maior é a eficiência operacional da empresa.</td>
        </tr>
        <tr>
            <td style="text-align:center">Retorno sobre o Capital Próprio (ROE)</td>
            <td>Razão entre o lucro líquido dos últimos 12 meses e o patrimômio líquido da empresa</td>
            <td style="text-align:center">O próprio indicador</td>
            <td>Quanto maior o ROE, maior é a eficiência da empresa na aplicação de seus próprios recursos.</td>
        </tr>
        <tr>
            <td style="text-align:center">Média da variação dos lucros</td>
            <td>Média da variação dos lucros líquidos da empresa nos útlimos 5 anos a partir do ano de referência.</td>
            <td style="text-align:center">O próprio indicador</td>
            <td>Quanto maior a média, maior foi o crescimentos dos lucros da empresa, o que indica um maior potencial de retorno dos lucros futuros.</td>
        </tr>
    </tbody>
    <tfoot>
        <tr>
            <td style="text-align:center" colspan="4">Fonte: Elaboração própria</td>
        </tr>
    </tfoot>
</table>

Ainda quanto aos indicadores, vale salientar que para alguns deles a função $U(C)$ teve que ser redefinida por partes ([Tabela 8](#table8)) a fim de evitar a ocorrência de valores espúrios, como, por exemplo, a margem líquida de uma empresa apresentar valor positivo por conta da divisão entre lucro e receita negativos, o que daria uma falsa impressão de que a empresa teria uma boa eficiência operacional.

Para contornar esse problema, arbitrou-se que a função $U(C)$ de um indicador espúrio sempre seria um número negativo, cujo valor seria o resultado da multiplicação do módulo do indicador por um impacto $I_j \lt -1$. A motivação disso é dada pela necessidade de evitar a possibilidade de que empresas diferentes acabem por receber um valor parecido para o mesmo indicador.

Para exemplificar, consideremos 3 empresas, A, B e C, em que a empresa A possui R$ 10 milhões de patrimônio, porém com um lucro líquido de -R$ 1 milhão nos últimos 12 meses (isto é, um prejuízo de R$ 1 milhão); a empresa B possui um lucro líquido de R$ 1 milhão, porém com um PL de -R$ 10 milhões; enquanto a empresa C possui os mesmos valores, porém ambos negativos. Caso o ROE fosse calculado para estas empresas, A e B teriam um ROE de -10%, enquanto C teria ROE de +10%, o que é incongruente com a verdadeira desejabilidade do investidor. Caso a ordem de preferência entre essas três empresas fosse formada exclusivamente pelos dados de lucro e patrimônio líquidos anteriormente fornecidos, concordar-se-ia que $A \succ B \succ C$. A empresa A seria preferível a B pois seria menos pior investir em uma empresa que teve prejuízo, mas possui alguma reserva de riqueza para se financiar, do que em uma empresa com lucro porém com a mesma quantia em saldo devedor no patrimônio líquido. E a empresa B seria preferível a C, pois, se fosse para investir em duas empresas com o mesmo saldo devedor em patrimônio líquido, menos pior seria investir em uma empresa lucrativa do que a com prejuízos. Portanto, cabe ao tomador de decisão estimar o quão pior seria escolher entre um ou outro em cada um dos cenários para melhor adequar as funções $U(C)$ às suas necessidades.

Neste trabalho, ainda tomando o caso do ROE como exemplo, arbitrou-se que, caso PL > 0, a sua desejabilidade seria calculado normalmente, isto é, $U(\text{ROE}) = \text{ROE}$; caso PL &lt; 0 e LL &gt; 0, $U(\text{ROE}) = -3|\text{ROE}|$, porque considerou que seria 3 vezes pior investir numa empresa com PL &lt; 0 e LL &gt; 0 do que em uma cujos PL e LL seriam os mesmos mas com LL &lt; 0 e PL &gt; 0. Já para quando ambas as métricas fossem negativas, o impacto foi arbitrado como $I_j = -5$, ou seja, seria 5 vezes pior para o tomador de decisão investir em uma empresa com PL e LL negativos do que em uma empresa com os mesmos valores absolutos de PL e LL, mas com a primeira sendo positiva e a segunda, negativa.

A função utilidade dos indicadores P/L e P/VP não necessitaram ser definidas por partes, uma vez que o preço de uma ação (ou valor de mercado da empresa) nunca seria negativo, não havendo portanto preocupação sobre a ocorrência de valores espúrios para esses indicadores.

<table id="table8">
    <caption style="text-align:center;"><strong>Tabela 8 – Definição por parte da função</strong></caption>
    <thead>
        <tr>
            <th style="text-align:center">Critério</th>
            <th style="text-align:center"><em>U(C)</em></th>
            <th style="text-align:center">Justificativa</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td style="text-align:center">DL/PL</td>
            <td>Se PL > 0, então: -DL/PL<br>Se DL < 0, então: -3|DL/PL|<br>Caso contrário: -5|DL/PL|</td>
            <td>Em relação ao pior cenário não espúrio, em que DL > 0 e PL > 0, foi considerado 3 vezes pior investir em empresa com PL &lt; 0 porém com DL < 0, e 5 vezes pior em uma com PL < 0 e DL &gt; 0.</td>
        </tr>
        <tr>
            <td style="text-align:center">DL/EBIT</td>
            <td>Se EBIT > 0, então: -DL/EBIT<br>Se DL < 0, então: -3|DL/EBIT|<br>Caso contrário: -5|DL/EBIT|</td>
            <td>Em relação ao pior cenário não espúrio, em que DL > 0 e EBIT > 0, foi considerado 3 vezes pior investir em empresa com EBIT &lt; 0 porém com DL < 0, e 5 vezes pior em uma com EBIT < 0 e DL &gt; 0</td>
        </tr>
        <tr>
            <td style="text-align:center">ROE</td>
            <td>Se PL > 0, então: LL / PL<br>Se LL > 0, então: -3|LL / PL|<br>Caso contrário:-5|LL/PL|</td>
            <td>Em relação ao pior cenário não espúrio, em que LL &lt; 0 e PL &gt; 0, foi considerado 3 vezes pior investir em empresa com PL &lt; 0 porém com LL &gt; 0, e 5 vezes pior em uma com ambos negativos</td>
        </tr>
        <tr>
            <td style="text-align:center">Margem Líquida</td>
            <td>Se RL > 0, então: LL/RL<br>Se LL > 0, então: -3|LL/RL|<br>Caso contrário: -5|LL/RL|</td>
            <td>Em relação ao pior cenário não espúrio, em que LL &lt; 0 e RL &gt; 0, foi considerado 3 vezes pior investir em empresa com RL < 0 porém com LL < 0, e 5 vezes pior em uma com ambos negativos.</td>
        </tr>
    </tbody>
    <tfoot>
        <tr>
            <td style="text-align:center" colspan="4">Fonte: Elaboração própria</td>
        </tr>
    </tfoot>
</table>

Por fim, quanto ao indicador da média da variação dos lucros, empregou-se a média aritmética em vez da geométrica devido à ocorrência de média negativa para os retornos de algumas empresas, o que impossibilitou o seu devido uso.

## **MODELAGEM**

Nesta fase, diversas técnicas de modelagem são selecionadas e aplicadas e seus parâmetros são calibrados para valores ótimos. Normalmente, existem diversas técnicas para o mesmo tipo de problema de mineração de dados e algumas possuem requisitos específicos quanto aos tipos e à formatação dos dados. Portanto, muitas vezes é necessário voltar à fase de preparação dos dados (CHAPMAN _et al_., 2000).

A técnica empregada no projeto proposto neste trabalho é inspirada no trabalho de Lima _et al_. (2012), em que os autores realizaram a avaliação de 3 MPEs com um modelo de FCD seguido de um ajuste com um método multicritério executado pelo _software_ Macbeth.

Inspirado nisso, o modelo de _valuation_ apresentado neste trabalho propõe a classificação das ações das empresas brasileiras negociadas na B3, por meio da estimação de um valor intrínseco inicial pelo método de FCD, o qual será ajustado pelo coeficiente de similaridade ($CC$) calculado pelo TOPSIS. O valor intrínseco ajustado será então utilizado para calcular a sua margem de segurança, que representa o seu potencial de valorização (ou desvalorização, caso negativo), com o qual será feita a ordenação decrescente das ações por cada setor ao fim do processo.

Os dados financeiros das empresas e seus indicadores e múltiplos fundamentalistas foram obtidos automaticamente de várias fontes – como foi apresentado na [Tabela 6](#table6) – com o auxílio do Power Query, uma aplicação presente no Microsoft Excel e no Power BI voltado para criação e edição de processos ETL.

Para o método do FCD, inicialmente, adotou-se o cálculo das FCFF com o intuito de considerar a alavancagem das empresas para o cálculo do valor intrínseco da ação. Portanto, a taxa de desconto inicialmente adotada foi o WACC, cujo cálculo do custo de capital próprio $r_E$ considerou como fator de risco de mercado o _bottom-up_ beta.

A taxa livre de risco $R_f$ foi dada como sendo a média geométrica dos retornos reais da taxa Selic no ano de referência (12 meses), enquanto o retorno médio do mercado $E[R_m]$ será dada pela média dos retornos reais do mercado brasileiro nos últimos 30 anos. A justificativa para isso se deve à compreensão de que a taxa Selic se trata de uma taxa de curto prazo, cujas variações futuras são altamente dependentes das variações passadas, não sendo portanto relevante considerar um intervalo de tempo maior do que 1 ano para o cálculo do seu valor esperado para o próximo ano. Enquanto os retornos de mercado são compreendidos como sendo de longo prazo, sendo necessário uma ampla série histórica que preferencialmente abranja vários ciclos de mercado para uma boa estimativa do seu valor esperado.

O índice inicialmente adotado para o cálculo do retorno de mercado esperado foi o IBrA, uma vez que este visa avaliar o desempenho médio das cotações de todos os ativos negociados na B3, desde que atendam a critérios mínimos de liquidez e presença em pregão (B3, 2023), sendo, portanto, um melhor representante da carteira de mercado brasileira se comparado com outros índices. No entanto, como no ano da confecção deste trabalho viu-se que o IBrA não apresentava nenhuma série histórica que fosse suficientemente longa para os propósitos deste trabalho, adotou-se como seu substituto o Ibovespa.

Entretanto, ao longo da confecção da modelagem, viu-se uma grande dificuldade em calcular apropriadamente o valor do capital de terceiros $D$ para várias empresas, principalmente das financeiras. O valor de foi inicialmente calculado como sendo o somatório das contas dos empréstimos, financiamentos recebidos e demais passivos financeiros, circulantes e não circulantes, constados nos seus respectivos BPs. Porém, ao aplicar essa fórmula, quase todas as empresas financeiras apresentaram fatores de alavancagem $\frac{D}{E}$ extremamente elevados quando comparados com algumas não financeiras, o que distorcia bastante os seus _bottom-up_ betas e, consequentemente, as suas taxas de desconto. Tais distorções também foram percebidas para algumas empresas não financeiras.

Devido a isso, houve um impedimento de calcular adequadamente os valores de $r_D$, $r_E$, _bottom-up_ beta, e as proporções de estrutura de capital $\frac{E}{E+D}$ e $\frac{D}{E+D}$, todas necessárias para o cálculo adequado do WACC. Portanto, devido a esta limitação, adotou-se o cálculo dos FCFEs no lugar dos FCFFs a fim de calcular os fluxos de caixa aos acionistas sem precisar levar em consideração o capital de terceiros das empresas. Os FCFEs foram calculados pela equação (2.8), onde as parcelas FCO, FCI e FCF correspondem, respectivamente, às contas de Caixa Líquido - Atividades Operacionais \[6.01\], Caixa Líquido - Atividades de Investimento \[6.02\] e Caixa Líquido - Atividades de Financiamento \[6.03\], constados nas suas respectivas DFCs. Como a conta \[6.01\] já considerava, além do Caixa Gerado nas Operações \[6.01.01\], as Variações nos Ativos e Passivos \[6.01.02\], não viu-se necessidade do cálculo da variação da necessidade de capital de giro ($\Delta NCG$) das empresas, com o receio de estar-se contabilizando a variação dos ativos e passivos duas vezes.

Além da substituição dos FCFFs pelos FCFEs, o modelo passou a se restringir a calcular a taxa de desconto como sendo apenas o custo do capital próprio $r_E$ da empresa, conforme a fórmula apresentada na equação (2.13). Portanto, o risco sistemático do mercado de uma ação passou a ser não mais o _bottom-up_ beta, mas sim o $\beta_{\text{setor}}$ calculado pela equação (2.12). Como arbitrou-se nesse trabalho que os bancos comporiam um setor próprio, à parte do setor financeiro, então o $\beta_{\text{setor}}$ calculado para os bancos refere-se exclusivamente ao beta do segmento bancário; enquanto o $\beta_{\text{setor}}$ das demais empresas financeiras refer-se apenas ao beta do setor financeiro, excluindo-se os bancos.

Para a projeção dos FCFEs no horizonte de projeção, considerou-se as DFCs dos últimos 5 anos a partir da data de referência para realizar uma projeção para os próximos 3 anos. Como cálculo para a projeção dos FCFEs, empregou-se a seguinte regra: caso os FCFEs não apresentassem algum _outlier_ no horizonte histórico, então os FCFEs projetados corresponderiam à média dos FCFEs históricos; caso contrário, corresponderiam à mediana. Essa regra foi arbitrada depois de serem observadas algumas distorções nos FCFE projetados ao empregar regressão linear – utilizando os anos da série histórica como variável independente e os FCFEs históricos como a dependente –, em que os FCFEs projetados eram demasiadamente superesetimados ou demasiadamente subestimados quando comparados ao horizonte histórico.

Por fim, para calcular o valor terminal do fluxo de caixa na perpetuidade, considerou-se como taxa de crescimento na perpetuidade $g$ a média geométrica das variações do PIB dos últimos 100 anos, ou seja, considerou-se que o crescimento perpétuo esperado de todas as empresas analisadas seguiriam ao do PIB brasileiro no último século. Esse intervalo de tempo foi arbitrado para a série histórica do PIB uma vez que o fator $g$ se trata de uma taxa de longuíssimo prazo.

Dada às algumas inconsistências encontradas nas quantidades de ações de cada uma das empresas nos registros de capital social da CVM, não havia garantia de que o cálculo do $VIA$ pela [equação 2.7](#eq2-7) fosse adequada para todas as empresas. Por conta disso, a margem de segurança $MS$ foi calculada diretamente da comparação entre o $VIM$ e o valor atual de mercado $VM$ da empresa por meio da seguinte modificação feita da [equação 2.2](#eq2-2).

<span id="eq3-1">

$$
\begin{array}{lr}
    MS = \frac{VIM-VM}{VM} 100\text{\%} & \text{(3.1)}
\end{array}
$$

</span>

Dado o que foi explicado, o cálculo do valor intrínseco de mercado inicial $VIM_0$ das empresas foi feita pela seguinte equação:

<span id="eq3-2">

$$
\begin{array}{lr}
    VIM_0 = \sum_{t=1}^{3}{\frac{FCFE_t}{(1+r_E)^t}} + \frac{FCFE_3(1+g)}{(1+r_E)^3(r_E-g)} & \text{(3.2)}
\end{array}
$$

</span>

Após a obtenção do $VIM_0$, os indicadores fundamentalistas constados na [Tabela 7](#table7) foram calculados a partir das demonstrações contábeis das empresas obtidas na CVM. Devido à grande diferença de volume do capital de terceiros entre as empresas bancárias e as demais empresas, utilizou-se os Índice de Basileia e de Imobilização como medidas de endividamento dos bancos no lugar do DL/PL e DL/EBIT. Além disso, como comentado anteriormente, uma vez que os balanços patrimoniais da CVM não separam os ativos e os passivos dos bancos em circulante e não circulante, não foi possível calcular os seus ILCs, sendo necessário substituí-lo pelo indicador ILG como indicador de liquidez das financeiras.

Para a aplicação do modelo TOPSIS, é ideal que fique a cargo do tomador de decisão quais os pesos serão atribuídos a cada um dos indicadores fundamentalistas que configurarão nos critérios da tomada de decisão, de modo que reflitam o seu perfil de investimento. Como não era possível definir qual os melhores pesos para cada indicador – tarefa que exige a consulta de opinião de especialistas na área de investimentos –, decidiu-se que estes seriam definidos pelo método da Entropia, explicado no referencial teórico.

Após o cálculo dos indicadores e de seus pesos, o TOPSIS se encarrega de calcular o coeficiente de similaridade $CC$ para cada uma das ações a fim de obter um fator de ágio $f_A$ – que se trata simplesmente de uma normalização Min-Máx do $CC$–, cujo propósito é reescalar o intervalo da sua imagem de \[0,1\] para \[-1,1\].

<span id="eq3-3">

$$
\begin{array}{lr}
    f_A = (2 \cdot CC - 1) \cdot 100\text{\%} & \text{(3.3)}
\end{array}
$$

</span>

Dessa forma, o $VIM_0$ foi ajustado por meio de um ágio (ou deságio) da avaliação comparativa conduzida pelo TOPSIS, obtendo o valor intrínseco final da ação como sendo:

<span id="eq3-4">

$$
\begin{array}{lr}
    VIM = VIM_0 (1+f_A) = 2 \cdot VIM_0 \cdot CC & \text{(3.4)}
\end{array}
$$

</span>

Com os $VIM$s obtidos, uma margem de segurança $MS$ é calculada e as ações são ordenadas em ordem decrescente de $MS$. A [Figura 3](#figure3) apresenta resumidamente o fluxograma do processo ETL aplicado.

|<span id="figure3">Figura 3</span> – Fluxograma ETL da proposta de _valuation_|
|:---:|
|![Figura 3](https://cdn.jsdelivr.net/gh/rodrigo-cl-porto/Valuation-DFC-TOPSIS-Entropia/docs/assets/figure3.png)|
|Fonte: Elaboração própria|

Após o cálculo das margens seguranças após a aplicação do TOPSIS, viu-se que as mesmas apresentavam valores super ou sobre valorizados para algumas ações, havendo empresas com $VIM$s avaliados em centenas de vezes o seu valor de mercado ou correspondendo a milésimos de seu valor de mercado. As margens de segurança foram calculadas também para logo após a avaliação intrínseca do DFC e viu-se que a partir dali já havia essas distorções.

A mais provável causa dessas distorções se deve ao cálculo não adequado dos FCFEs das empresas (que não refletem a sua real expectativa de crescimento no curto, médio, longo e longuíssimo prazo, a atual maturidade econômica etc.) ou da sua taxa de desconto $r_E$ (que não reflete adequadamente os seus riscos operacionais, financeiros, setoriais etc.) ou de ambas. Para corrigir isso, seria necessário uma avaliação minuciosa sobre o perfil de risco de cada uma das empresas consideradas no modelo, o que acaba por se tornar inviável para este trabalho, uma vez que se trata de uma amostra com dezenas ou centenas de empresas, dependendo do ano de referência da _valuation_.

Ainda, houve algumas empresas avaliadas com $VIM$ negativo, as quais pode ser explicadas por terem parcelas relevantes de FCFE negativos ao longo do seu período histórico considerado, o que acabou por terem parcelas relevantes de FCFEs negativos no seu horizonte de projeção, que quando trazidas ao valor presente resultou em um $VIM$ negativo. Tais empresas foram descartadas da amostra e, portanto, não foram consideradas para a avaliação comparativa com TOPSIS.

Porém, apesar das distorções das margens de segurança, acredita-se que estas não comprometeriam seriamente os resultados da _valuation_, uma vez que o objetivo do cálculo das $MS$s não é calcular com precisão o real potencial de valorização das ações, mas sim para simplesmente ordenar as ações por ordem descrescente de $MS$. Além disso, nem todas as ações consideradas comporão a carteria selecionada do ano da avaliação, somente as que tiveram maiores classificações após a aplicação do modelo proposto de _valuation_.

## **AVALIAÇÃO**

O propósito desta fase consiste em validar os resultados do modelo construído antes de avançar para a sua implementação, realizando uma avaliação minuciosa e revisando as etapas executadas para garantir que ele atenda de maneira eficaz aos objetivos de negócios estabelecidos. Ao final desta etapa, uma decisão será tomada em relação à utilização dos resultados da mineração de dados (CHAPMAN et al., 2000).

Para avaliar os potenciais de valorização fornecidas pelo modelo de _valuation_, buscou-se rodar _backtests_ que comparassem os retornos de uma carteira selecionada com os retornos históricos do mercado (Ibovespa). Para tanto, foram conduzidos _backtests_ que aplicavam a proposta de _valuation_ deste trabalho como critério de ordenação das ações, selecionando as ações com os maiores potenciais de valorização de cada setor para compor a carteira selecionada para o ano que vem.

O período histórico considerado foi o de 2016 a 2023 (8 anos), assumindo que a carteira selecionada está sendo formada no dia 31 de dezembro do ano anterior ao ano de referência da carteira. Por exemplo, a carteira selecionada a ser performada ao longo de 2019 foi formada pelo investidor no último dia de 2018. Arbitrou-se que a carteira selecionada seria composta por 20 ações, por considerar-se ser a quantidade suficiente para diluir os riscos específicos das ações, buscando haver uma quantidade igual de ações para cada setor, com a distribuição mais diluída possível. Por exemplo, caso sobrasse 11 setores a serem considerados, buscar-se-ia compor um portifólio com 9 setores com 2 ações cada e 2 setores com apenas uma ação cada, somando as 20.

Assumiu-se ainda que a proporção de capital a ser aplicada para cada uma das ações fossem iguais entre si, ou seja, se houvesse R$ 20.000,00 para serem investidos numa carteira de 20 ações, seriam aplicadas R$ 1.000,00 em cada ação. Por conta disso, a rentabilidade de uma carteira pode ser calculada simplesmente pela média aritmética dos retornos de cada uma das ações que a compõem.

Ao final de cada ano do _backtest_, foram aplicadas as seguintes regras:

- Para as ações da carteira selecionada do ano anterior que não estivessem presentes na carteira selecionada do ano atual, considerou-se que elas teriam a posição zerada (venda total) e o dinheiro da sua venda seria completamente reinvestido;
- Ações novas que surgem na carteira de um ano para o outro são compradas para compor a carteira atual.;
- A carteira seria rebalanceada em todos os anos, somente no dia 31 de dezembro, de modo que o capital investido fosse equiibrado para todos os papéis.

Na [Tabela 9](#table9) constam os resultados das carteiras selecionadas dadas pelo modelo de _valuation_ proposto. O gráfico consta a comparação entre os retornos das carteiras selecionadas e o do Ibovespa.

<table id="table9" style="text-align:center">
    <caption style="text-align:center;"><strong>Tabela 9 – Carteiras Selecionadas (2016 – 2023)</strong></caption>
    <thead>
        <tr>
            <th colspan="2" style="text-align:center">2016</th>
            <th colspan="2" style="text-align:center">2017</th>
            <th colspan="2" style="text-align:center">2018</th>
            <th colspan="2" style="text-align:center">2019</th>
            <th colspan="2" style="text-align:center">2020</th>
            <th colspan="2" style="text-align:center">2021</th>
            <th colspan="2" style="text-align:center">2022</th>
            <th colspan="2" style="text-align:center">2023</th>
        </tr>
        <tr>
            <th>Ticker</th><th>Retorno</th>
            <th>Ticker</th><th>Retorno</th>
            <th>Ticker</th><th>Retorno</th>
            <th>Ticker</th><th>Retorno</th>
            <th>Ticker</th><th>Retorno</th>
            <th>Ticker</th><th>Retorno</th>
            <th>Ticker</th><th>Retorno</th>
            <th>Ticker</th><th>Retorno</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>CSNA3</td><td>171,25%</td>
            <td>IGTI3</td><td>294,12%</td>
            <td>EMAE4</td><td>100,77%</td>
            <td>POSI3</td><td>354,91%</td>
            <td>LUXM4</td><td>146,12%</td>
            <td>PATI3</td><td>217,84%</td>
            <td>AALR3</td><td>46,14%</td>
            <td>BBAS3</td><td>59,49%</td>
        </tr>
        <tr>
            <td>FLRY3</td><td>122,81%</td>
            <td>MTSA4</td><td>59,58%</td>
            <td>BALM4</td><td>58,75%</td>
            <td>CSAN3</td><td>107,92%</td>
            <td>EMAE4</td><td>104,20%</td>
            <td>PTNT3</td><td>167,01%</td>
            <td>CPFE3</td><td>24,58%</td>
            <td>VIVA3</td><td>52,70%</td>
        </tr>
        <tr>
            <td>USIM3</td><td>105,47%</td>
            <td>GSHP3</td><td>43,11%</td>
            <td>SLCE3</td><td>56,96%</td>
            <td>EMAE4</td><td>102,13%</td>
            <td>VALE3</td><td>64,07%</td>
            <td>UNIP3</td><td>111,04%</td>
            <td>MOAR3</td><td>22,43%</td>
            <td>VBBR3</td><td>46,37%</td>
        </tr>
        <tr>
            <td>LUPA3</td><td>94,69%</td>
            <td>PSSA3</td><td>35,06%</td>
            <td>BBAS3</td><td>46,10%</td>
            <td>WIZC3</td><td>101,43%</td>
            <td>MRFG3</td><td>45,68%</td>
            <td>SLCE3</td><td>64,04%</td>
            <td>BRAP4</td><td>18,98%</td>
            <td>AZUL4</td><td>45,41%</td>
        </tr>
        <tr>
            <td>LPSB3</td><td>73,80%</td>
            <td>CYRE3</td><td>28,72%</td>
            <td>OFSA3</td><td>40,42%</td>
            <td>PINE4</td><td>90,05%</td>
            <td>TOTS3</td><td>33,48%</td>
            <td>LUXM4</td><td>28,13%</td>
            <td>ITUB4</td><td>18,71%</td>
            <td>VIVT3</td><td>39,35%</td>
        </tr>
        <tr>
            <td>EQTL3</td><td>58,88%</td>
            <td>ODPV3</td><td>26,27%</td>
            <td>BBDC4</td><td>25,60%</td>
            <td>MRFG3</td><td>82,42%</td>
            <td>SHUL4</td><td>33,27%</td>
            <td>CSAN3</td><td>14,25%</td>
            <td>SLCE3</td><td>14,59%</td>
            <td>PTNT4</td><td>36,00%</td>
        </tr>
        <tr>
            <td>MULT3</td><td>56,26%</td>
            <td>JOPA4</td><td>25,50%</td>
            <td>GOAU4</td><td>19,86%</td>
            <td>ECOR3</td><td>73,77%</td>
            <td>MOAR3</td><td>32,35%</td>
            <td>CGRA4</td><td>7,03%</td>
            <td>SOND3</td><td>14,45%</td>
            <td>ITUB4</td><td>35,88%</td>
        </tr>
        <tr>
            <td>BMKS3</td><td>35,20%</td>
            <td>EQTL3</td><td>20,68%</td>
            <td>EQTL3</td><td>13,57%</td>
            <td>CCRO3</td><td>69,46%</td>
            <td>CGRA4</td><td>18,24%</td>
            <td>BEEF3</td><td>3,63%</td>
            <td>GOAU4</td><td>13,47%</td>
            <td>CSNA3</td><td>35,12%</td>
        </tr>
        <tr>
            <td>FRAS3</td><td>13,68%</td>
            <td>BMKS3</td><td>19,77%</td>
            <td>MOAR3</td><td>11,45%</td>
            <td>PTNT4</td><td>57,14%</td>
            <td>PNVL3</td><td>11,04%</td>
            <td>EMAE4</td><td>0,78%</td>
            <td>CMIG4</td><td>10,47%</td>
            <td>CSAN3</td><td>13,08%</td>
        </tr>
        <tr>
            <td>MOAR3</td><td>13,13%</td>
            <td>MULT3</td><td>19,40%</td>
            <td>BRAP4</td><td>10,34%</td>
            <td>EQTL3</td><td>52,83%</td>
            <td>CSAN3</td><td>8,85%</td>
            <td>TOTS3</td><td>-0,14%</td>
            <td>GGBR4</td><td>7,74%</td>
            <td>BBDC4</td><td>12,81%</td>
        </tr>
        <tr>
            <td>KEPL3</td><td>11,11%</td>
            <td>TKNO4</td><td>16,63%</td>
            <td>MSPA3</td><td>2,13%</td>
            <td>GEPA3</td><td>44,58%</td>
            <td>PTNT4</td><td>8,69%</td>
            <td>WIZC3</td><td>-0,25%</td>
            <td>PTNT4</td><td>-0,32%</td>
            <td>MRFG3</td><td>12,13%</td>
        </tr>
        <tr>
            <td>FESA4</td><td>9,92%</td>
            <td>RDNI3</td><td>12,84%</td>
            <td>JOPA3</td><td>-8,00%</td>
            <td>OFSA3</td><td>27,60%</td>
            <td>EQTL3</td><td>1,62%</td>
            <td>EQTL3</td><td>-2,37%</td>
            <td>TOTS3</td><td>-3,46%</td>
            <td>CRIV4</td><td>11,46%</td>
        </tr>
        <tr>
            <td>MRFG3</td><td>4,09%</td>
            <td>POSI3</td><td>11,47%</td>
            <td>MTSA4</td><td>-8,30%</td>
            <td>ODPV3</td><td>22,69%</td>
            <td>GEPA4</td><td>-7,91%</td>
            <td>VALE3</td><td>-9,95%</td>
            <td>TAEE4</td><td>-3,96%</td>
            <td>MTSA4</td><td>4,97%</td>
        </tr>
        <tr>
            <td>OSXB3</td><td>0,00%</td>
            <td>EGIE3</td><td>1,46%</td>
            <td>PTNT4</td><td>-10,00%</td>
            <td>AGRO3</td><td>21,84%</td>
            <td>JBSS3</td><td>-8,29%</td>
            <td>JOPA3</td><td>-17,71%</td>
            <td>BRSR3</td><td>-9,62%</td>
            <td>WIZC3</td><td>3,42%</td>
        </tr>
        <tr>
            <td>NEMO3</td><td>0,00%</td>
            <td>NEMO3</td><td>0,00%</td>
            <td>GEPA3</td><td>-15,12%</td>
            <td>ABEV3</td><td>21,39%</td>
            <td>ODPV3</td><td>-13,75%</td>
            <td>BALM4</td><td>-18,85%</td>
            <td>RAPT4</td><td>-23,98%</td>
            <td>NEMO3</td><td>0,00%</td>
        </tr>
        <tr>
            <td>ENAT3</td><td>-8,58%</td>
            <td>TCSA3</td><td>-4,01%</td>
            <td>CGRA4</td><td>-17,42%</td>
            <td>BBAS3</td><td>13,62%</td>
            <td>PCAR3</td><td>-15,56%</td>
            <td>BBDC4</td><td>-22,14%</td>
            <td>VBBR3</td><td>-26,34%</td>
            <td>JOPA3</td><td>-6,67%</td>
        </tr>
        <tr>
            <td>ATMP3</td><td>-21,67%</td>
            <td>SUZB3</td><td>-6,60%</td>
            <td>POSI3</td><td>-27,97%</td>
            <td>BBDC4</td><td>12,30%</td>
            <td>BBSE3</td><td>-21,41%</td>
            <td>GEPA4</td><td>-24,36%</td>
            <td>AZUL4</td><td>-54,75%</td>
            <td>EMAE4</td><td>-13,22%</td>
        </tr>
        <tr>
            <td>SLED4</td><td>-24,75%</td>
            <td>BEEF3</td><td>-12,35%</td>
            <td>UGPA3</td><td>-29,07%</td>
            <td>UNIP3</td><td>11,38%</td>
            <td>BBAS3</td><td>-26,54%</td>
            <td>BBAS3</td><td>-25,64%</td>
            <td>MRFG3</td><td>-60,58%</td>
            <td>POSI3</td><td>-25,88%</td>
        </tr>
        <tr>
            <td>WLMM4</td><td>-48,00%</td>
            <td>JBSS3</td><td>-13,95%</td>
            <td>PINE4</td><td>-36,86%</td>
            <td>CIEL3</td><td>-5,85%</td>
            <td>POMO4</td><td>-36,22%</td>
            <td>BBSE3</td><td>-29,53%</td>
            <td>BRFS3</td><td>-61,38%</td>
            <td>BEEF3</td><td>-42,36%</td>
        </tr>
        <tr>
            <td>IGTI3</td><td>-49,00%</td>
            <td>CSNA3</td><td>-22,76%</td>
            <td>BEEF3</td><td>-53,15%</td>
            <td>EMBR3</td><td>-8,99%</td>
            <td>WIZC3</td><td>-43,06%</td>
            <td>FLRY3</td><td>-33,42%</td>
            <td>OIBR3</td><td>-77,63%</td>
            <td>AALR3</td><td>-51,85%</td>
        </tr>
    </tbody>
    <tfoot>
        <tr>
            <th>Média</th><th>30,92%</th>
            <th>Média</th><th>27,75%</th>
            <th>Média</th><th>9,00%</th>
            <th>Média</th><th>62,63%</th>
            <th>Média</th><th>16,74%</th>
            <th>Média</th><th>21,47%</th>
            <th>Média</th><th>-6,52%</th>
            <th>Média</th><th>13,41%</th>
        </tr>
        <tr>
            <td style="text-align:center" colspan="16">Fonte: Elaboração própria</td>
        </tr>
    </tfoot>
</table>

Ao final da realização do _backtest_, comparou-se os retornos das carteiras selecionadas pelo método FCD-TOPSIS Entropia com os retornos do Ibovespa a fim de verificar se ela conseguia superar a carteira de mercado brasileira com consistência ao longo do período considerado ([Gráfico 4](#graphic4)).

|<span id="graphic4">Gráfico 4</span> – Retornos das Carteiras Selecionadas vs Retornos do Ibovespa|
|:---:|
|![Gráfico 4](https://cdn.jsdelivr.net/gh/rodrigo-cl-porto/Valuation-DFC-TOPSIS-Entropia/docs/assets/figure4.png)|
|Fonte: Elaboração própria|

Pelos resultados do [Gráfico 4](#graphic4), viu-se que as carteiras selecionadas superam o Ibovespa em metade dos anos do período analisado, não sendo portanto possível chegar a uma conclusão sobre a contribuição do método TOPSIS quanto à consistência em superar o principal índice de mercado brasileiro no longo prazo. Contudo, ao se comparar os retornos total e médio ao longo dos anos entre as carteiras selecionadas (345,70% e 20,54% a.a., respectivamente) e o Ibovespa (209,43% e 15,17% a.a., respectivamente), é possível verificar que as rentabilidades da primeira superam as da última. Tais retornos foram calculados segundo as [Equações 3.5](#eq3-5) e [3.6](#eq3-6), respectivamente. Como as rentabilidades totais + 1 foram positivas para ambas as carteiras, foi possível comparar os seus retornos médios pela média geométrica no lugar da aritmética.

<span id="eq3-5">

$$
\begin{array}{lr}
    \text{Retorno Total} = R = \prod_{i=1}^{8}{(1+R_i)} - 1 & \text{(3.5)}
\end{array}
$$

</span>

<span id="eq3-6">

$$
\begin{array}{lr}
    \overline{R} = \sqrt[8]{\prod_{i=1}^{8}{(1+R_i)}} - 1 & \text{(3.6)}
\end{array}
$$

</span>

Além disso, ainda se baseando nos retornos anuais, é possível verificar que o beta das carteiras selecionadas foi de 0,63, ou seja, o método FCD-TOPSIS Entropia se mostrou menos sensível às variações de mercado, indicando ser uma carteira de investimentos em ações segura.

## **IMPLANTAÇÃO**

A criação do modelo geralmente não marca o término do projeto, mas sim constitui apenas uma parte dele, podendo haver sempre oportunidades de iniciar um novo ciclo. Conforme explicado por Chapman _et al_. (2000), a fase de implementação varia bastante em complexidade, podendo ser tão simples quanto gerar um relatório ou tão elaborada quanto estabelecer um processo de mineração de dados replicável em toda uma empresa. Geralmente, a implementação não é conduzida pelo cientista ou analista de dados.

Embora a implementação não constitua um dos focos primordiais do presente trabalho, o modelo de _valuation_ foi publicado no perfil GitHub do autor, localizado no repositório [Valuation-DFC-TOPSIS-Entropy](https://github.com/rodrigo-cl-porto/valuation_dfc_topsis_entropia). Isso proporcionará aos interessados a oportunidade de testar, avaliar, criticar, aprimorar e utilizar o modelo para fins pessoais ou profissionais, ampliando assim a colaboração e a transparência no desenvolvimento e na aplicação dessa ferramenta.

# **ANÁLISE E DISCUSSÃO DOS RESULTADOS**

Com o intuito de avaliar melhor a eficácia do modelo e a contribuição do método TOPSIS para a melhora da performance da carteira, além de buscar uma análise mais conclusiva quanto à consistência da carteira em performar melhor do que o índice de referência do mercado, foram realizadas mais _backtests_ para 4 variações do modelo de valuation trabalhado até então. Além do modelo DFC-TOPSIS com Entropia, foram criados:

- FCD-TOPSIS, sem o Método da Entropia, em que foram atribuídos o mesmo peso para todos os critérios;
- TOPSIS com Entropia, em que as ações são ordenadas não mais pela margem de segurança, mas pelo $CC$ calculado pelo TOPSIS;
- TOPSIS, sem Entropia, em que atribuiu o mesmo peso para todos os critérios e as ações são ordenadas pelo $CC$;
- FCD, sem TOPSIS, em que as ações são ordenadas pela sua margem de segurança, sem haver um ajuste do valor de mercado intríseco calculado pelo método FCD.

O _backtest_ do modelo FCD foi utilizado como um grupo de controle para avaliar a contribuição da adição do TOPSIS aos modelos de _valuation_, observando seu impacto na performance da carteira e na consistência em superar os retornos do Ibovespa ao longo do tempo. Os resultados da simulação constam na [Tabela 10](#table10) e no [Gráfico 5](#graphic5). Vale ressaltar que a métrica $S$ da [Tabela 10](#table10) se refere ao índice Sharpe (SHARPE, 1994), uma medida de desempenho que relaciona o prêmio do risco e o próprio risco de um ativo e informa o quanto de rentabilidade adicional – isto é, além da rentabilidade livre de risco –, por unidade de risco incorrido para obtê-la, cujo cálculo é dado por:

<span id="eq4-1">

$$
\begin{array}{lr}
    S = \frac{R_i-R_f}{\sigma_i} & \text{(4.1)}
\end{array}
$$

</span>

Onde:

- $R_i$ é o retorno acumulado do ativo ao longo do período – neste caso, de 2016 a 2023
- $R_f$ é o retorno do ativo livre de risco – que foi dada pela taxa Selic acumulada no período (92,69%)
- $\sigma_i$ é o desvio-padrão dos retornos do ativo ao longo do período.

<table id="table10" style="text-align:center">
    <caption style="text-align:center;"><strong>Tabela 10 – Retornos das carteiras dos modelos de backtest</strong></caption>
    <thead>
        <tr>
            <th style="text-align:center">Ano</th>
            <th style="text-align:center">FCD</th>
            <th style="text-align:center">FCD-TOPSIS Entropia</th>
            <th style="text-align:center">FCD-TOPSIS</th>
            <th style="text-align:center">TOPSIS Entropia</th>
            <th style="text-align:center">TOPSIS</th>
            <th style="text-align:center">Ibovespa</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>2016</td>
            <td>45,89%</td>
            <td>30,92%</td>
            <td>27,15%</td>
            <td>76,66%</td>
            <td>31,33%</td>
            <td>38,91%</td>
        </tr>
        <tr>
            <td>2017</td>
            <td>27,59%</td>
            <td>27,75%</td>
            <td>28,99%</td>
            <td>79,90%</td>
            <td>66,40%</td>
            <td>26,84%</td>
        </tr>
        <tr>
            <td>2018</td>
            <td>5,59%</td>
            <td>9,00%</td>
            <td>11,50%</td>
            <td>18,21%</td>
            <td>-5,64%</td>
            <td>15,04%</td>
        </tr>
        <tr>
            <td>2019</td>
            <td>67,56%</td>
            <td>62,63%</td>
            <td>64,58%</td>
            <td>35,20%</td>
            <td>60,59%</td>
            <td>31,58%</td>
        </tr>
        <tr>
            <td>2020</td>
            <td>2,41%</td>
            <td>16,74%</td>
            <td>12,04%</td>
            <td>18,62%</td>
            <td>31,94%</td>
            <td>2,93%</td>
        </tr>
        <tr>
            <td>2021</td>
            <td>26,63%</td>
            <td>21,47%</td>
            <td>31,98%</td>
            <td>6,98%</td>
            <td>0,86%</td>
            <td>-11,92%</td>
        </tr>
        <tr>
            <td>2022</td>
            <td>-6,01%</td>
            <td>-6,52%</td>
            <td>1,12%</td>
            <td>-25,08%</td>
            <td>-23,57%</td>
            <td>4,68%</td>
        </tr>
        <tr>
            <td>2023</td>
            <td>22,52%</td>
            <td>13,41%</td>
            <td>16,41%</td>
            <td>6,48%</td>
            <td>22,28%</td>
            <td>22,26%</td>
        </tr>
    </tbody>
    <tfoot>
        <tr>
            <th style="text-align:center"><em>R</em></th>
            <th style="text-align:center">391,77%</th>
            <th style="text-align:center">345,70%</th>
            <th style="text-align:center">423,89%</th>
            <th style="text-align:center">414,10%</th>
            <th style="text-align:center">311,85%</th>
            <th style="text-align:center">209,43%</th>
        </tr>
        <tr>
            <th style="text-decoration:overline;text-align:center;"><em>R</em></th>
            <th style="text-align:center">22,03%</th>
            <th style="text-align:center">20,54%</th>
            <th style="text-align:center">23,00%</th>
            <th style="text-align:center">22,71%</th>
            <th style="text-align:center">19,36%</th>
            <th style="text-align:center">15,17%</th>
        </tr>
        <tr>
            <th style="text-align:center"><em>&beta;</em></th>
            <th style="text-align:center">0,89</th>
            <th style="text-align:center">0,63</th>
            <th style="text-align:center">0,46</th>
            <th style="text-align:center">1,49</th>
            <th style="text-align:center">1,15</th>
            <th style="text-align:center">1,00</th>
        </tr>
        <tr>
            <th style="text-align:center"><em>S</em></th>
            <th style="text-align:center">13,20</th>
            <th style="text-align:center">13,41</th>
            <th style="text-align:center">18,28</th>
            <th style="text-align:center">9,58</th>
            <th style="text-align:center">7,45</th>
            <th style="text-align:center">7,38</th>
        </tr>
        <tr>
            <td style="text-align:center" colspan="7">Fonte: Elaboração própria</td>
        </tr>
    </tfoot>
</table>

|<span id="graphic5">Gráfico 5</span> – Retornos dos modelos vs Retornos do Ibovespa|
|:---:|
|![Gráfico 5](https://cdn.jsdelivr.net/gh/rodrigo-cl-porto/Valuation-DFC-TOPSIS-Entropia/docs/assets/graphic5.png)|
|Fonte: Elaboração própria|

Pelos resultados obtidos, é possível ver que o modelo TOPSIS Entropia foi o que mais teve êxito em superar o Ibovespa, batendo o seu retorno em 6 dos 8 anos do período simulado, o que indicou ser o modelo mais adequado para o investidor que vise ganhos acima do mercado consistentes. Infelizmente, o mesmo não pôde ser concluído para o modelo FCD-TOPSIS Entropia, originalmente proposto, que só superou o Ibovespa em metade dos anos, o que não foi o suficiente para concluir se ele é eficaz em bater os retornos do mercado com consistência no longo prazo. O mesmo resultado inconclusivo foi encontrado para o FCD-TOPSIS, sem o método da Entropia. Curiosamente, os modelos que utilizaram os métodos separadamente (apenas o FCD ou o apenas o TOPSIS), obtiveram uma eficácia maior do que quando os dois foram empregados conjuntamente, superando o mercado em 5 dos 8 anos. Porém, essa pequena diferença não possibilitou concluir se estes modelos mais simples são mais eficazes no longo prazo do que os que aplicam ambos.

No entanto, apesar dos resultados inconclusivos quanto à eficácia de alguns modelos, foi possível verificar que todos os modelos de _valuation_ testados para o período de 2016 a 2023 obtiveram rendimentos total e médio maiores do que os do Ibovespa, com 3 deles sendo menos sensíveis às variações do mercado ($\beta \lt 1$). Do menos rentável para o mais rentável, temos TOPSIS, FCD, FCD-TOPSIS Entropia, TOPSIS Entropia e FCD-TOPSIS. Ou seja, dos modelos que empregaram o TOPSIS, 3 deles conseguiram superar o _backtest_ de controle FCD, com 2 deles tendo um $\beta$ menor do que o grupo de controle.

Já ao analisar o índice Sharpe, viu-se que todos os _backtests_ obtiveram um desempenho melhor na relação risco-retorno do que o Ibovespa, sendo o FCD-TOPSIS o que mais obteve rentabilidade excessiva por unidade de risco ($S=18,28$), o que era esperado já que foi o que obteve a maior rentabilidade com o menor . Além disso, o FCD-TOPSIS e FCD-TOPSIS Entropia obtiveram melhor desempenho do que as duas ferramentas de avaliação separadamente, o que pode indicar uma relevante constribuição do TOPSIS em otimizar o binômio risco-retorno quando aplicado em conjunto com o FCD.

O TOPSIS Entropia, apesar de ter sido o modelo mais eficaz, foi o segundo mais rentável e o mais arriscado de todos ($\beta=1,49$), além de ter sido o segundo menos eficiente ($S=9,58$), indicando um possível custo de compensação ao querer buscar a carteira que bate com consistência os ganhos do mercado anualmente. E comparando este modelo com o TOPSIS, e o modelo FCD-TOPSIS Entropia com FCD-TOPSIS, não foi possível chegar uma conclusão sobre a contribuição da definição dos pesos dos critérios pelo método da Entropia para a rentabilidade ou eficiência da carteira. Pois, ao aplicar a Entropia no TOPSIS, há um ganho de 3,35 pontos percentuais na rentabilidade média anual e 2,13 unidades de rentabilidade por unidade de risco no $S$; entretanto, há uma perda de 2,46 pontos percentuais na rentabilidade média anual e de 4,87 no $S$ quando a Entropia é aplicada ao FCD-TOPSIS. Já quanto ao risco, viu-se que, em ambos os casos, a Entropia acabou tornando as carteiras mais arriscadas. Essas comparações feitas aos pares de modelos com e sem Entropia indicam que considerar apenas o valor informacional dos indicadores fundamentalistas das empresas por setor não garente que a eficiência da carteira se eleve.

# **CONCLUSÕES**

Apesar das distorções percebidas na margem de segurança de algumas empresas desde a etapa de avaliação intrínseca do FCD, a avaliação dos _backtests_ mostrou que o próprio modelo FCD superou o rendimento histórico do Ibovespa e obteve um $\beta \lt 1$. Os _backtests_ também forneceram um bom indício da contribuição da avaliação comparativa das empresas pelo método multicritério TOPSIS à otimização do risco-retorno das carteiras quando combinado à avaliação intrínseca realizada pelo FCD, cumprindo assim com o objetivo desse trabalho. Tal indício contribui para a hipótese de que é importante não só avaliar o valor da empresa pela expectativa do seu fluxo de caixa mas também pelos seus indicadores fundamentalistas, a fim de averiguar se os fundamentos da empresa se adequa ao perfil do investidor.

Portanto, em relação à questão motivadora deste trabalho, apresentado no tópico de objetivos, pode-se dizer que ela foi parcialmente respondida, pois foi possível verificar que uma metodologia que combine as avaliações intríseca do FCD e comparativa do TOPSIS ajudou a otimizar o binômio risco-retorno, apesar de a questão da consistência na performance da carteira não ter sido conclusiva.

Porém, para futuros trabalhos que envolvam algum método de avaliação intríseca, como o DFC, recomenda-se uma avaliação mais minuciosa para o cálculo dos fluxos de caixa e suas projeções e da taxa de desconto, em preferência a um processo automatizado aplicado a todas as empresas, a fim de evitar ou minimizar a ocorrência de possíveis distorções no cálculo dos valores intrínsecos, o que traria mais credibilidade aos modelos de _valuation_ a serem desenvolvidos. Caso possível, também recomenda-se como índice de referência do mercado brasileiro o IBrA no lugar do Ibovespa, uma vez que a carteira teórica do Índice Brasil Amplo considera um maior número de ações.

A partir da experiência durante a etapa da extração de dados, recomenda-se aos futuros autores o uso de APIs financeiros para uma fácil extração de dados e rápido desenvolvimento de seus trabalhos, uma vez que os dados dos demonstrativos contábeis das empresas disponibilizados pela CVM não se mostraram confiáveis para algumas métricas. Além disso, as cotações disponibilizadas pela B3 não se mostraram adequadas para o cálculo dos retornos do mercado, uma vez que as cotações históricas de fechamento não são ajustadas de acordo com eventos societários relevantes.

Além disso, para futuros trabalhos envolvendo a aplicação de métodos multicritério de apoio à decisão, seria interessante analisar a contribuição dos indicadores fundamentalistas para o potencial de crescimento de uma empresa, cujas correlações podem ser verificadas com o uso de Machine Learning ou modelos de Inteligência Artificial, e definir mais apropriadamente os seus pesos a partir dessa metodologia.

Por fim, além dos indicadores financeiros, recomenda-se aos futuros autores de trabalhos com análise fundamentalista o acréscimo de indicadores que reflete o comprometimento das empresas com as questões ESG, os quais não foram possíveis de serem incluídos na avaliação comparativa deste trabalho pela falta de uma boa fonte de dados que informasse tais indicadores para todas as empresas negociadas na B3 – ou, pelo menos, para a maioria delas -, o que tornou inviável a avaliação quanto às práticas empresariais de sustentabilidade ambiental, social e social.

# **REFERÊNCIAS**

- ANBIMA. Segurança, rentabilidade e liquidez: entenda o tripé dos investimentos! __Como Investir__, 16 fev 2023. Disponivel em: <https://comoinvestir.anbima.com.br/noticia/seguranca-rentabilidade-e-liquidez-entenda-o-tripe-dos-investimentos/>. Acesso em: 30 nov 2023.
- B3. B3. __5 milhões de contas de investidores__, 2022. Disponivel em: <https://www.b3.com.br/pt_br/noticias/5-milhoes-de-contas-de-investidores.htm>. Acesso em: 01 jun 2024.
- B3. Índice Bovespa (Ibovespa B3). __B3__, 2023. Disponivel em: <https://www.b3.com.br/pt_br/market-data-e-indices/indices/indices-amplos/ibovespa.htm>. Acesso em: 20 out. 2023.
- B3. Índice Brasil Amplo BM&FBOVESPA (IBrA B3). __B3__, 2023. Disponivel em: <https://www.b3.com.br/pt_br/market-data-e-indices/indices/indices-amplos/indice-brasil-amplo-ibra.htm>. Acesso em: 01 dez. 2023.
- B3. Número de investidores na B3 cresce 34% em renda fixa e 23% em renda variável em 12 meses. __B3__, 5 jun. 2023. Disponivel em: <https://www.b3.com.br/pt_br/noticias/numero-de-investidores-na-b3-cresce-34-em-renda-fixa-e-23-em-renda-variavel-em-12-meses.htm>. Acesso em: 13 out. 2023.
- BAINHA, J. D. S.; SODRÉ, C. C. D. S. __Fundos de investimento no Brasil: uma análise de desempenhos dos fundos de renda fixa, ações e multimercados de janeiro de 2010 a dezembro de 2019__. Universidade Federal de Santa Catarina. Florianópolis, p. 81. 2022. (<https://repositorio.ufsc.br/handle/123456789/243241>).
- BANCO DATA. Banco Data. __Banco Data__, 2024. Disponivel em: <https://bancodata.com.br/relatorio/bb/>. Acesso em: 19 Maio 2024.
- BORFE, I. A.; SCHWERZ, M. B. __Um estudo sobre a rentabilidade dos no Brasil__. Universidade de Cruz Alta. Cruz Alta, p. 27. 2018.
- BRASIL. Lei 6404/76. __Comissão de Valores Mobiliários__, 1976. Disponivel em: <https://conteudo.cvm.gov.br/legislacao/leis-decretos/lei6404.html>. Acesso em: 16 out. 2023.
- CAMARGOS, M. A. D.; BARBOSA, F. V. Eficiência informacional do mercado de capitais brasileiro pós-Plano Real: um estudo de eventos dos anúncios de fusões e aquisições. __Revista de Administração__, São Paulo, v. 41, n. 1, p. 43-58, jan-mar. 2006.
- CAMARGOS, M. A. D.; BARBOSA, F. V. Eficiência informacional do mercado de capitais brasileiro em anúncios de fusões e aquisições. __Production__, v. 25, n. 3, p. 571-584, jul. 2015.
- CARVALHO, L. F.; GIACHERO, O. S.; RIBEIRO, K. C. D. S. __Uma crítica a Hipótese da Eficiência de Mercado:__ Análise dos casos Ambev e Submarino. \[S.l.\]: \[s.n.\].
- CHAPMAN, P. _et al._ __CRISP-DM 1.0: Step-by-step data mining guide__. SPSS. \[S.l.\], p. 78. 2000.
- DAMODARAN, A. __Valuation:__ Como avaliar empresas e escolher as melhores ações. Tradução de Afonso Celso da Cunha Serra. 1ª. ed. Rio de Janeiro: LTC, 2012. p. 220. ISBN 978-85-216-2050-1.
- DE BONDT, W. F. M.; THALER, R. Does the Stock Market Overreact? __The Journal of Finance__, Dallas, v. 40, n. 3, p. 793–805, jul. 1985.
- DUARTE, R. D. M. __Análise dos fundos renda fixa e variável no Brasil, período 2007-2017: Um estudo sobre a volatilidade entre fundos agressivos e conservadores__. Universidade de Caxias do Sul. Caxias do Sul, p. 59. 2019. (<https://repositorio.ucs.br/11338/5052>).
- FAMA, E. F. Efficient Capital Markets: A Review of Theory and Empirical Work. __The Journal of Finance__, Nova York, 25, maio 1970., p. 383-417
- FILHO, J. C. F. D. A. _et al._ __Finanças Corporativas__. 10ª. ed. Rio de Janeiro: Editora FGV, 2008. p. 152. ISBN 978-85-225-0675-0.
- FORTI, C. A. B.; PEIXOTO, F. M.; SANTIAGO, W. D. P. Hipótese da eficiância de mercado: um estudo exploratório. __Gestão & Regionalidade__, v. 25, n. 75, p. 45-56, set-dez. 2009.
- GITMAN, L. J. __Princípios de Adminstração Financeira__. Tradução de Allan Vidigal Hastings. 12. ed. São Paulo: Pearson, 2013. ISBN 978-85-7605-332-3.
- GRAHAM, B. __O investidor inteligente:__ O guia clássico para ganhar dinheiro na bolsa. Tradução de Lourdes Sette. 1ª. ed. Rio de Janeiro: HarperCollins Brasil, 2016. p. 908. ISBN 978-85-209-2577-5.
- HEIN, N.; KROENKE, A.; WILHEIM, V. E. Análise Multicritério de Materiais de Construção – sobre o uso da entropia como medida de importância. __Scientia Plena__, v. 9, n. 7, jul. 2013. ISSN 1808-2793. Disponivel em: <https://www.scientiaplena.org.br/sp/article/view/1287>. Acesso em: 08 dez. 2023.
- HENDGES, M. A.; RODRIGUES, M. R. __Estudo do mercado de ações e sua comparação com investimento em renda fixa__. Fundação Educaional Machado de Assis. Santa Rosa, p. 30. 2021.
- HWANG, C. L.; YOON, K. Multiple Attribute Decision Making: Methods and Applications. __Lecture Notes in Economics and Mathematical Systems__, Berlin, v. 186, n. 1, p. 58-191, fev. 1981. ISSN 978-3-642-48318-9.
- KOBORI, J. __Análise Fundamentalista:__ Como obter uma performance superior e consistente no mercado de ações. 2ª. ed. Rio de Janeiro: \[s.n.\], 2018. p. 208. ISBN 978-85-508-0472-9.
- LIMA, L. A. D. O. Auge e declínio da hipótese dos mercados eficientes. __Brazilian Journal of Political Economy__, 23, out-dez. 2003., p. 531-546
- LIMA, M. V. A. D. _et al._ Avaliação de micro e pequenas empresas utilizando a metodologia multicritério e o método do fluxo de caixa descontado. __Revista de Ciências da Administração__, v. 12, n. 26, p. 48–71, jan-abr. 2010.
- MICROSOFT. O que é Power Query? __Microsoft Learn__, 2024. Disponivel em: <https://learn.microsoft.com/pt-br/power-query/power-query-what-is-power-query>. Acesso em: 19 Maio 2024.
- NETO, A. A.; LIMA, F. G.; ARAÚJO, A. M. P. D. Uma proposta metodológica para o cálculo do custo de capital no Brasil. __Revista de Administração__, São Paulo, v. 43, n. 1, p. 72-83, jan-mar. 2008.
- PÓVOA, A. __Valuation:__ Como precificar ações. 1ª. ed. São Paulo: Elsevier Brasil, 2012. p. 480. ISBN 978-85-352-5685-7.
- REIS, T. FCFE: entenda o que é e como funciona o Fluxo de Caixa do Acionista. __Suno__, 5 abr. 2023. Disponivel em: <https://www.suno.com.br/artigos/fcfe/>. Acesso em: 21 out. 2023.
- RIBEIRO, O. M. __Contabilidade Geral Fácil__. 6ª. ed. São Paulo: Saraiva, 2010. p. 536. ISBN 978-85-02-09191-7.
- SAATY, T. How to make a decision: the analytic hierarchy process. __European Journal of Operational Research__, v. 24, n. 6, p. 19-43, 1994.
- SCHERER, D. Índice Beta. __Clube de Finanças__, 16 nov. 2020. Disponivel em: <http://clubedefinancas.com.br/materias/indice-beta/>. Acesso em: 20 out. 2023.
- SHARPE, W. F. The Sharpe Ratio. __The Journal of Portfolio Management__, v. 21, n. 1, p. 49-58, 1994.
- SIEGEL, J. J. __Investindo em ações no longo prazo:__ o guia indispensável do investidor no mercado financeiro. Tradução de Beth Honorato. 5ª. ed. Porto Alegre: Bookman, 2015. p. 387. ISBN 978-85-8260-323-9.
- STATUS INVEST. Dívida Líquida/Patrimônio Líquido. __Status Invest__, 30 set. 2020. Disponivel em: <https://statusinvest.com.br/termos/d/divida-liquida-patrimonio-liquido>. Acesso em: 18 out. 2023.
- STATUS INVEST. Liquidez Corrente. __Status Invest__, 30 set. 2020. Disponivel em: <https://statusinvest.com.br/termos/l/liquidez-corrente>. Acesso em: 18 out. 2023.
- STATUS INVEST. Margem Líquida. __Status Invest__, 30 set. 2020. Disponivel em: <https://statusinvest.com.br/termos/m/margem-liquida>. Acesso em: 18 out. 2023.
- STATUS INVEST. P/VP. __Status Invest__, 30 set. 2020. Disponivel em: <https://statusinvest.com.br/termos/p/p-vp>. Acesso em: 18 out. 2023.
- STATUS INVEST. ROE. __Status Invest__, 30 set. 2020. Disponivel em: <https://statusinvest.com.br/termos/r/roe>. Acesso em: 18 out. 2023.
- STATUS INVEST. Dívida Líquida/EBIT. __Status Invest__, 30 mar. 2021. Disponivel em: <https://statusinvest.com.br/termos/d/divida-liquida-ebit>. Acesso em: 18 out. 2023.
- STATUS INVEST. Dividend Yield. __Status Invest__, 7 abr. 2021. Disponivel em: <https://statusinvest.com.br/termos/d/dividend-yield>. Acesso em: 18 out. 2023.
- TORO. Quais são as principais e maiores Bolsas de Valores do mundo hoje? __Toro Blog__, 16 jun. 2023. Disponivel em: <https://blog.toroinvestimentos.com.br/bolsa/principais-bolsas-de-valores-do-mundo>. Acesso em: 13 out. 2023.