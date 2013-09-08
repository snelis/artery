import os
import sys
import site
import params
from django.core.handlers.wsgi import WSGIHandler

# Define some directories to work with
artery_core_dir = os.path.abspath(os.path.dirname(__file__))
artery_dir = os.path.dirname(artery_core_dir)
src_dir = os.path.dirname(artery_dir)
base_dir = os.path.dirname(src_dir)

version_string = "{0}.{1}".format(sys.version_info[0], sys.version_info[1])
venv_packages_dir = os.path.join(base_dir, 'venv/lib', 'python{0}'.format(version_string), 'site-packages')

site.addsitedir(src_dir)
site.addsitedir(venv_packages_dir)

# Directly assign to os.environ instead of using os.environ.setdefault as the former plays nice
# with having multiple django sites run from one WSGIProcessGroup, as done on test server.
# There seems to be no use case where the DJANGO_SETTINGS_MODULE needs to be defined elsewhere.
# See comment in default Django project wsgi
os.environ["DJANGO_SETTINGS_MODULE"] = "artery.settings"


def get_wsgi_application():
    """
    The public interface to Django's WSGI support. Should return a WSGI
    callable.
    """
    ENV = getattr(params, 'ENV', None)

    # Get the WSGIHandler
    application = WSGIHandler()

    try:
        # Celery
        import newrelic.agent

        newrelic_ini = os.path.join(base_dir, 'etc', 'newrelic.ini')

        # Wrap the application around a newrelic wsgi handler
        newrelic.agent.initialize(newrelic_ini, ENV)
        application = newrelic.agent.wsgi_application()(application)

    except ImportError:
        pass

    return application
