using System;
using System.ComponentModel;
using System.Diagnostics;

namespace ImdbClientAppMVVM.ViewModel
{
    /// <summary>
    /// This class is used as the basis for all ViewModel objects
    /// </summary>
    public class ViewModel : INotifyPropertyChanged, IDisposable
    {
        /// <summary>
        /// Occurs when a property value changes.
        /// </summary>
        public event PropertyChangedEventHandler PropertyChanged = delegate { };

        /// <summary>
        /// This can be used to indicate that all property values have changed.
        /// </summary>
        protected void OnPropertyChanged()
        {
            OnPropertyChanged(null);
        }

        /// <summary>
        /// This raises the INotifyPropertyChanged.PropertyChanged event to indicate
        /// a specific property has changed value.
        /// </summary>
        /// <param name="name"></param>
        protected virtual void OnPropertyChanged(string name)
        {
            Debug.Assert(string.IsNullOrEmpty(name) || GetType().GetProperty(name) != null);
            PropertyChanged(this, new PropertyChangedEventArgs(name));
        }

        #region IDisposable Members

        /// <summary>
        /// This disposes of the view model.  It unregisters from the message mediator.
        /// </summary>
        /// <param name="isDisposing">True if IDisposable.Dispose was called</param>
        protected virtual void Dispose(bool isDisposing)
        {
        }

        /// <summary>
        /// Implementation of IDisposable.Dispose.
        /// </summary>
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        #endregion
    }
}

