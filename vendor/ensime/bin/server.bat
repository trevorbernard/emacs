set PORT_FILE=%1
set CLASSPATH="lib\ant-1.6.5.jar;lib\ant-1.8.1.jar;lib\ant-launcher-1.8.1.jar;lib\asm-3.2.jar;lib\asm-commons-3.2.jar;lib\asm-tree-3.2.jar;lib\backport-util-concurrent-3.1.jar;lib\classworlds-1.1-alpha-2.jar;lib\commons-logging-1.1.1.jar;lib\critbit-0.0.4.jar;lib\ensime_2.9.1-0.8.0.RC3.jar;lib\expectj-2.0.1.jar;lib\ivy-2.1.0.jar;lib\maven-ant-tasks-2.1.0.jar;lib\maven-artifact-2.2.1.jar;lib\maven-artifact-manager-2.2.1.jar;lib\maven-error-diagnostics-2.2.1.jar;lib\maven-model-2.2.1.jar;lib\maven-plugin-registry-2.2.1.jar;lib\maven-profile-2.2.1.jar;lib\maven-project-2.2.1.jar;lib\maven-repository-metadata-2.2.1.jar;lib\maven-settings-2.2.1.jar;lib\nekohtml-1.9.6.2.jar;lib\org.eclipse.jdt.core-3.6.0.v_A58.jar;lib\org.scala-refactoring_2.9.2-SNAPSHOT-0.3.0-SNAPSHOT.jar;lib\plexus-container-default-1.0-alpha-9-stable-1.jar;lib\plexus-interpolation-1.11.jar;lib\plexus-utils-1.5.15.jar;lib\scala-compiler.jar;lib\scala-library.jar;lib\scalariform_2.9.1-0.1.1.jar;lib\wagon-file-1.0-beta-6.jar;lib\wagon-http-lightweight-1.0-beta-6.jar;lib\wagon-http-shared-1.0-beta-6.jar;lib\wagon-provider-api-1.0-beta-6.jar;lib\xercesMinimal-1.9.6.2.jar"
if "%ENSIME_JVM_ARGS%"=="" (set ENSIME_JVM_ARGS=-XX:+DoEscapeAnalysis -Xms256M -Xmx1512M -XX:PermSize=128m -Xss1M -Dfile.encoding=UTF-8)
java -classpath %CLASSPATH% %ENSIME_JVM_ARGS% org.ensime.server.Server %PORT_FILE%
