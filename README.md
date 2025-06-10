## 1. Pré-requisitos

- **Java Development Kit (JDK) 17:** Certifique-se de que o JDK 17 está instalado e configurado no seu sistema.
- **Eclipse IDE for Enterprise Java and Web Developers:** Use esta versão do Eclipse.
- **Apache Tomcat 9.0.x:** Baixe e descompacte o Tomcat 9.0.x em um local acessível.

## 2. Baixar os JARs Faltantes

Você precisará baixar os arquivos `.jar` específicos. Use o [Maven Central Repository](https://search.maven.org/) mesmo que seu projeto não seja Maven.

- **JSTL 1.2:**  
  [Baixe aqui](https://mvnrepository.com/artifact/javax.servlet/jstl/1.2) (clique em "jar" para baixar `jstl-1.2.jar`).

- **PostgreSQL JDBC Driver (42.7.6):**  
  [Baixe aqui](https://mvnrepository.com/artifact/org.postgresql/postgresql/42.7.6) (clique em "jar" para baixar `postgresql-42.7.6.jar`).

## 3. Importar o Projeto para o Eclipse

1. Abra o Eclipse.
2. Vá em **File > Import...**
3. Expanda **General** > selecione **Existing Projects into Workspace**.
4. Clique em **Next**.
5. Em **Select root directory**, clique em **Browse...** e navegue até a pasta raiz do seu projeto.
6. O projeto deve aparecer na lista **Projects**. Certifique-se de que ele esteja marcado.
7. Clique em **Finish**.

## 4. Configurar o Tomcat 9 no Eclipse

1. Vá em **Window > Show View > Other...**. Digite "Servers" e selecione **Servers**. Clique em **Open**.
2. Na aba **Servers**, clique com o botão direito e selecione **New > Server**.
3. Expanda **Apache** e escolha **Tomcat v9.0 Server**. Clique em **Next**.
4. Em **Tomcat installation directory**, clique em **Browse...** e selecione a pasta do Tomcat.
5. Clique em **Finish**.

## 5. Adicionar os JARs Faltantes à Pasta lib do Projeto

1. No Eclipse, localize a pasta do seu projeto.
2. Navegue até:  
   `src/main/webapp/WEB-INF/lib`  
   > Se a pasta `webapp` não existir e for `WebContent`, use `WebContent/WEB-INF/lib`.  
   > Se a pasta `lib` não existir, crie-a.
3. Copie os arquivos `jstl-1.2.jar` e `postgresql-42.7.6.jar` para esta pasta.

## 6. Configurar o Java Build Path no Eclipse

1. Clique com o botão direito no seu projeto no **Package Explorer**.
2. Vá em **Properties**.
3. No menu à esquerda, selecione **Java Build Path**.
4. Vá para a aba **Libraries**.
5. Clique em **Add JARs...**.
6. Navegue até `src/main/webapp/WEB-INF/lib` e selecione ambos os JARs.
7. Clique em **OK**.
8. Para configurar o "Targeted Runtime" (Tomcat 9):
   - Ainda nas **Properties**, selecione **Targeted Runtimes**.
   - Marque o **Apache Tomcat v9.0**.
   - Clique em **Apply**.
   - Volte para a aba **Libraries** e verifique se uma entrada como "Apache Tomcat v9.0 [Apache Tomcat]" apareceu. Se não, clique em **Add Library... > Server Runtime > Next**, selecione o Tomcat e clique em **Finish**.
9. Clique em **Apply and Close**.

## 7. Configurar o Nível de Compilação Java

1. Clique com o botão direito no seu projeto no **Package Explorer**.
2. Vá em **Properties**.
3. No menu à esquerda, selecione **Java Compiler**.
4. Certifique-se de que **Compiler compliance level** está definido para **17**.
5. Se não estiver, mude para **17**.  
   > Pode ser necessário ajustar o "JRE System Library" também.
6. Clique em **Apply and Close**.

## 8. Limpar e Reconstruir o Projeto

1. Vá em **Project** no menu superior do Eclipse.
2. Selecione **Clean...**.
3. Selecione seu projeto e marque **Start a build immediately**.
4. Clique em **Clean**.

## 9. Adicionar o Projeto ao Servidor Tomcat 9 e Executar

1. Na aba **Servers** do Eclipse, clique com o botão direito no seu Apache Tomcat v9.0.
2. Selecione **Add and Remove...**.
3. Na coluna **Available**, selecione seu projeto e clique em **Add >**.
4. Clique em **Finish**.
5. Clique com o botão direito no Tomcat na aba **Servers**.
6. Selecione **Start**.
7. Verifique o console do Eclipse para quaisquer erros de inicialização.
