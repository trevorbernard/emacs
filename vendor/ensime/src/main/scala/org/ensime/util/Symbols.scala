package org.ensime.util

/*
* See source at root/scala/trunk/src/compiler/scala/tools/nsc/symtab/Symbols.scala
* for details on various symbol predicates.
* 
* This is split out to work around scala bug 4560.
* 
* https://issues.scala-lang.org/browse/SI-4560
*/

object Symbols {
  import scala.tools.nsc.symtab.Flags._
  val Method = 'method
  val Trait = 'trait
  val Interface = 'interface
  val Object = 'object
  val Class = 'class
  val Field = 'field
  val Nil = 'nil

  val Rename = 'rename
  val ExtractMethod = 'extractMethod
  val ExtractLocal = 'extractLocal
  val InlineLocal = 'inlineLocal
  val OrganizeImports = 'organizeImports
  val AddImport = 'addImport

  val QualifiedName = 'qualifiedName
  val File = 'file
  val NewName = 'newName
  val Name = 'name
  val Start = 'start
  val End = 'end
  val MethodName = 'methodName

}

