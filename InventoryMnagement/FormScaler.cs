using System;
using System.Drawing;
using System.Windows.Forms;

namespace InventoryMnagement
{
    public static class FormScaler
    {
        public static void ScaleForm(Form form)
        {
            // Get screen bounds (working area, which excludes the taskbar)
            Rectangle workingArea = Screen.PrimaryScreen.WorkingArea;
            
            double scaleX = 1.0;
            double scaleY = 1.0;
            
            // Add a 40px margin so the window isn't cramped against the screen edges
            int maxWidth = workingArea.Width - 40;
            int maxHeight = workingArea.Height - 40;
            
            // Calculate scale factor if the form is wider than the screen
            if (form.Width > maxWidth)
            {
                scaleX = (double)maxWidth / form.Width;
            }
            
            // Calculate scale factor if the form is taller than the screen
            if (form.Height > maxHeight)
            {
                scaleY = (double)maxHeight / form.Height;
            }
            
            // Use the smaller scaling factor to preserve aspect ratio and avoid distortion
            double scale = Math.Min(scaleX, scaleY);
            
            // Only scale down if the form is actually too large for the screen
            if (scale < 1.0)
            {
                float scaleFactor = (float)scale;
                
                // Scale the form and all nested child controls automatically!
                form.Scale(new SizeF(scaleFactor, scaleFactor));
                
                // Reposition the form to be perfectly centered on the screen after scaling
                form.StartPosition = FormStartPosition.Manual;
                form.Location = new Point(
                    workingArea.Left + (workingArea.Width - form.Width) / 2,
                    workingArea.Top + (workingArea.Height - form.Height) / 2
                );
            }
        }
    }
}
