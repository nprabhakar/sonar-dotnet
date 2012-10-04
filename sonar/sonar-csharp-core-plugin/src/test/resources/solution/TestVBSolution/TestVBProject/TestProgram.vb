Option Explicit On
Option Strict On

Imports System
Imports CSharpLibraryProject

Module TestProgram
    Sub Main()
		' Say hi in VB.NET.
		Console.WriteLine("Hello world")
		
		Dim instance As CSharpLibraryProject.MyClass
		instance = New CSharpLibraryProject.MyClass()
		instance.JustCall(5)
    End Sub
End Module