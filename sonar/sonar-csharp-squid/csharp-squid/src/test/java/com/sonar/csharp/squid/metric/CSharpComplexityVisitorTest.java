/*
 * Sonar C# Plugin :: C# Squid :: Squid
 * Copyright (C) 2010 Jose Chillan, Alexandre Victoor and SonarSource
 * dev@sonar.codehaus.org
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02
 */
package com.sonar.csharp.squid.metric;

import com.sonar.csharp.squid.CSharpConfiguration;
import com.sonar.csharp.squid.api.CSharpGrammar;
import com.sonar.csharp.squid.api.CSharpMetric;
import com.sonar.csharp.squid.scanner.CSharpAstScanner;
import com.sonar.sslr.squid.AstScanner;
import org.apache.commons.io.FileUtils;
import org.junit.Test;
import org.sonar.squid.api.SourceProject;
import org.sonar.squid.indexer.QueryByType;

import java.io.File;
import java.nio.charset.Charset;

import static org.hamcrest.Matchers.is;
import static org.junit.Assert.assertThat;

public class CSharpComplexityVisitorTest {

  @Test
  public void testScanFile() {
    AstScanner<CSharpGrammar> scanner = CSharpAstScanner.create(new CSharpConfiguration(Charset.forName("UTF-8")));
    scanner.scanFile(readFile("/metric/Money.cs"));
    SourceProject project = (SourceProject) scanner.getIndex().search(new QueryByType(SourceProject.class)).iterator().next();

    assertThat(project.getInt(CSharpMetric.COMPLEXITY), is(72));
  }

  @Test
  public void testScanSimpleFile() {
    AstScanner<CSharpGrammar> scanner = CSharpAstScanner.create(new CSharpConfiguration(Charset.forName("UTF-8")));
    scanner.scanFile(readFile("/metric/simpleFile.cs"));
    SourceProject project = (SourceProject) scanner.getIndex().search(new QueryByType(SourceProject.class)).iterator().next();

    assertThat(project.getInt(CSharpMetric.COMPLEXITY), is(15));
  }

  @Test
  public void testRealLifeFile() {
    AstScanner<CSharpGrammar> scanner = CSharpAstScanner.create(new CSharpConfiguration(Charset.forName("UTF-8")));
    scanner.scanFile(readFile("/metric/BasicConfigurator.cs"));
    SourceProject project = (SourceProject) scanner.getIndex().search(new QueryByType(SourceProject.class)).iterator().next();

    assertThat(project.getInt(CSharpMetric.COMPLEXITY), is(6));
  }

  protected File readFile(String path) {
    return FileUtils.toFile(getClass().getResource(path));
  }

}
