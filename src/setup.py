from setuptools import find_packages, setup
from artery import VERSION

setup(
    name="snelis",
    version=VERSION,
    license='BSD 3 Clause',
    description=('A set of tools to make the life of devops easier.\n'
                 'The aim is to quickly setup an isolated project locally '
                 'which can be easily rolled out to your production stack'),
    long_description=open('../README.md').read(),
    author='Niels Lensink',
    author_email='niels@nielslensink.com',
    url='https://github.com/snelis/snelis',
    keywords="snelis django vagrant puppet ngnix uwsgi upstart",
    scripts=['snelis/bin/snelis'],
    packages=find_packages(),
    include_package_data = True,
    install_requires=[
        'docopts',
        'django>=1.5'
    ])
