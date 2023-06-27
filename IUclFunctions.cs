using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.InteropServices;

namespace CRUFL_SIVSAUcl
{
    [ComVisible(true), InterfaceType(ComInterfaceType.InterfaceIsDual), Guid("CDD76EE0-BCE2-4167-AC6F-6F6FDFE3F855")]
    public interface IUclFunctions
    {
        string GetImage(string url);
    }
}
