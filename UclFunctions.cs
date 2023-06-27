using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Runtime.InteropServices;
using System.Net;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using System.Security.Policy;

namespace CRUFL_SIVSAUcl
{
    
    
    [ComVisible(true), ClassInterface( ClassInterfaceType.None ), GuidAttribute("5DEC94B8-D640-4D61-B2AC-6A72BA7A6FAB")]
    public class UclFunctions: IUclFunctions
    {

        public UclFunctions()
        {
        }

        public string GetImage(string url)
        {
            string filePath = string.Empty;

            try
            {
                System.Net.ServicePointManager.ServerCertificateValidationCallback = 
                    delegate (object sender, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors) { return true; };

                System.Net.ServicePointManager.Expect100Continue = true;
                System.Net.ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12 | SecurityProtocolType.Tls11;

                using (var webCli = new WebClient())
                {
                    Uri uri;
                    if (Uri.TryCreate(url, UriKind.Absolute, out uri))
                    {
                        filePath = Path.GetTempFileName();
                        webCli.DownloadFile(url, filePath);
                    }

                }
            }
            catch (Exception e)
            {
                filePath = "ERROR: " + e.Message;
            }


            return filePath;
        }


        




    }

}
