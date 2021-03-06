# iOSSchool2021-1_SBER

### Lession 2. Home task. 
#### В чем заключается разница между trunk-based и feature подходами?
###### TRUNK BASE DEVELOPMENT
  Начнем с того, что такое trunk-based development. 
  Trunk-based Development (TBD) - это подход, при котором разработка ведется на основе единственной ветки trunk (или master, если речь идет о git). Второстепенные ветки feature-ветки так же могут создаваться, однако они имеют крайне короткий срок жизни (не больше 2-х дней). При таком подходе участники вносят изменения в главную ветку несколько раз в день, тем самым выполняется требование непрерывной интеграции, согласно которому все разработчики обязуются делать коммиты в главную ветку не реже, чем раз в сутки. Этот способ гарантирует доступность кодовой базы по запросу и позволяет осуществлять непрерывную поставку.

  Подытожим главные особенности данного подхода:
- разработка осуществляется в главной ветке trunk (master);
- feature ветки могут появляться для различных целей, но должны существовать не более 2-х дней;
- разработчики делают коммиты в главную ветку не реже одного раза в день;
- в зависимости от частоты релизов можно использоваться ветки релизов, которые создаются от главной ветки, "замораживаются" перед релизом, и удаляются через некоторое время;
- использование техники Brach by abstraction для постепенного длительного внесения изменений в код, и использование в повседневной работе feature flags чтобы обеспечить порядок релизов;
- следует использоваться сервер сборки, для проверки кода перед добавлением в главную ветку, чтобы удостовериться, что новый коммит все не сломает;

###### FEATURE BRANCH WORKFLOW

  В отличие от trunk-based development, в feature branch workflow основная идея заключается в том, что вся работа над новой функциональностью производится в отдельной ветке, а не в master. Инкапсуляция подобного рода облегчает работу нескольких разработчиков над общей функциональностью в рамках одной кодовой базы. Это гаратирует, что нерабочий код не попадет в ветку master, если работа над проектом корректна и налажена.
  Такая изоляция работы позволяет эффективно использоваться pull request и merge request, которые являются способом инициализации изменений в ветке. Они позволяют другим разработчикам одобрить функциональность перед интеграцией в проект. Так же разработчик в случае какой-либо проблемы может создать запрос на объединение и спросить совета у своих коллег. Такие запросы позволяют участникам команды комментировать работу друг друга.
  В центре внимания модели Feature Brach лежит ветвление. Это значит, что она является основной используемой моделью для создания веток и управления ими. Данная модель используется в пройденной нами на лекции модели GitFlow.

  Основные особенности feature branch подхода:
- работа над проектов ведется в отдельной ветке feature;
- перед пушем в главую ветку производится проверка;
- она ориентирована на шаблоны ветвления;
- может быть использована вместе с другими моделями работы с репозиторием;
- способствует общению в команде посредством запросов на объединение и ревью кода;

###### Итог
  В заключение хотелось бы отметить, что принципиальная разница между этими двумя моделями заключается в различном подходе к ветвлению. В первой рассмотренной модели в основе лежит одна ветка, и разработка ведется в ней. Во второй модели же работа над проектом производится в feature ветках. Обе модели имеют свои особенности, указанные мною выше. 
Стоит отметить, что оба подхода на данный момент являются акутальными, и актуальность их использования зависит от условий и задач в проекте. К примеру, такие компании, как Google и Facebook используют Trunk-based подход для работы над своими проектами (***ист. trunkbaseddevelopment.com***). 


