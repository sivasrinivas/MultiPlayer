package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javacode.Server;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
 
boolean status = Server.status;

      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>Start Page</title>\n");
      out.write("<!--        <script type=\"text/javascript\" src=\"resources/jquery.js\"></script>\n");
      out.write("        <script type=\"text/javascript\">\n");
      out.write("            $(document).ready(function(){\n");
      out.write("                var status = ");
      out.print( status);
      out.write(";\n");
      out.write("                status = status.toString().trim();\n");
      out.write("                alert(status);\n");
      out.write("            });\n");
      out.write("        </script>-->\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("    <!--<div id=\"container\" style=\"width:80%;height:100%;border:solid;border-width:2px;\">-->\n");
      out.write("             <div id=\"header\" align=\"top\" style=\"width:100%;height:10%;border:solid;border-width:2px;background-color: #AD7460;\">\n");
      out.write("              <h1>Game Rules</h1>               \n");
      out.write("             </div>\n");
      out.write(" <div id=\"main\" style=\"width:100%;height:80%;\">\n");
      out.write("                <div id=\"tableDiv\" style=\"width:100%;height:100%;border:solid;border-width:2px;float:left;background-color: #F5D5BC;\">\n");
      out.write("                    <table>\n");
      out.write("                        \n");
      out.write("                        <tr><th>Step-1</th><td><h4> Remember the Tiles in 15 seconds and the game starts</h4></td></tr>\n");
      out.write("                        <tr><th>Step-1</th><td><h4> You can see all the online players in the right pane</h4></td></tr>\n");
      out.write("                        <tr><th>Step-2</th><td><h4> After that you have 35 seconds to finish off the game by matching the tiles</h4></td></tr>\n");
      out.write("                        <tr><th>Step-3</th><td><h4>Good Luck and press click enter to start the game</h4></td></tr>\n");
      out.write("                        <tr><td></td></tr>\n");
      out.write("       \n");
      out.write("       \n");
      out.write("                    </table>\n");
      out.write("   \n");
      out.write("      \n");
      out.write("                    <center> <img src=\"resources\\game1.png\"/></td></tr></center>\n");
      out.write("              \n");
      out.write("         \n");
      out.write("   \n");
      out.write(" \n");
      out.write("   \n");
      out.write("        \n");
      out.write("        <form name=\"submit\" action=\"game.jsp\" method=\"post\">\n");
      out.write("\t\t<!--<img src=\"resources\\pairmen.jpg\" />-->\n");
      out.write("\t\t<br>\n");
      out.write("\t\t<input type=\"submit\" id=\"enter\" value=\"Enter\"/>\n");
      out.write("\t</form>\n");
      out.write(" </div>\n");
      out.write(" </div>    \n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
