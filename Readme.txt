Comersus Lightsail antibot script v1.0

------------------Description

Autonomous script to block likely bot activity in Amazon AWS Lightsail based on number of requests

------------------Installation

Upload the script to /home/bitnami/ using FTP or copy/paste with 
sudo nano antibotfree.sh

Edit your own IPs and your instance server IPs to avoid being blocked in this line:
if [ "${stringarray[1]}" = "127.0.0.1" ] || [[ "${stringarray[1]}" == "54."* ]]  ;

Edit the number of request to start blocking:
limit=300

Assign permissions with: 
sudo chmod -R 775 antibotfree.sh

Create a cron job to autoexecute the script at X minutes:
cronjob -e

Add this 2 lines at the end of cronjob:
*/5 * * * * /home/bitnami/antibotfree.sh >> /home/bitnami/antibotlog.txt 2>&1
@reboot /sbin/iptables-restore < /opt/bitnami/iptables-rules

------------------Use

Every X minutes the script will be called by cronjob, server requests will be verified from Apache logs and if they are higher than 300 (or the limit specified), IP will be blocked
You can view execution logs at antibotlog.txt file

You can also run manually the script using:
sudo su
. antibotfree.sh

------------------Paid version

Free version does not discriminate between good and bad traffic. Only the number of requests is verified. A web crawler like MSN bot could be blocked unless you whitelist the IP.
With the paid version, besides the number of requests, traffic is analyzed to block for example common SQL Injection and Wordpress vulnerabilities scans.
More information about paid version at http://comersus.com

------------------License


THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES,
INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL COMERSUS OR ITS CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
