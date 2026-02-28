"""
This file is part of DevOrSysAdminScripts library.

DevOrSysAdminScripts is free software:
you can redistribute it and/or modify it under the terms
of the GNU Lesser General Public License
as published by the Free Software Foundation,
either version 3 of the License,
or (at your option) any later version.

DevOrSysAdminScripts is distributed in the hope
that it will be useful,
but WITHOUT ANY WARRANTY;
without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU Lesser General Public License for more details.

You should have received a copy of
the GNU Lesser General Public License
along with DevOrSysAdminScripts.
If not, see <https://www.gnu.org/licenses/>.

©Copyright 2023-2026 Laurent Frédéric Bernard François Lyaudet

Pour transférer d'un compte IMAP à un autre
Penser à autoriser les apps moins sûres sur Gmail si nécessaire
"""

import argparse
import email
import imaplib


class IMAPTransfertBadArgumentError(Exception):
    """
    A class to avoid a linter warning,
    that needs an Error suffix to avoid another linter warning,
    that needs a docstring to avoid another linter warning.
    If you don't see its intent, try badminton.
    """


class SurpriseError(Exception):
    """
    A class to avoid a linter warning,
    that needs an Error suffix to avoid another linter warning,
    that needs a docstring to avoid another linter warning.
    If you don't see its intent after seeing its use, try volleyball.
    But "Cheer up!", now you don't need "pass" XD.
    """


def IMAP_transfert(
    from_login: str,
    from_password: str,
    from_host: str,
    from_port: int,
    to_login: str,
    to_password: str,
    to_host: str,
    to_port: int,
    *,
    to_new_folder: str = "",
    verbose: bool = False,
) -> None:
    """
    Transfert all emails from some IMAP account
    to another IMAP account.
    """
    empty = ""
    if from_login == "":
        raise IMAPTransfertBadArgumentError("From login is empty.")
    # if from_password == "":
    if from_password == empty:
        # https://github.com/PyCQA/bandit/issues/714
        # Dumb
        raise IMAPTransfertBadArgumentError("From password is empty.")
    if from_host == "":
        raise IMAPTransfertBadArgumentError("From host is empty.")
    if from_port <= 0:
        raise IMAPTransfertBadArgumentError(
            "From port is not positive.",
        )
    if to_login == "":
        raise IMAPTransfertBadArgumentError("To login is empty.")
    if to_password == empty:
        # And Dumber The infinite collection XD
        raise IMAPTransfertBadArgumentError("To password is empty.")
    if to_host == "":
        raise IMAPTransfertBadArgumentError("To host is empty.")
    if to_port <= 0:
        raise IMAPTransfertBadArgumentError(
            "To port is not positive.",
        )
    # pylint: disable=pointless-string-statement
    """
    Maybe one day Python will ship something like that in its standard
    library:
    https://www.php.net/manual/fr/function.filter-var.php
    But now urlparse doesn't do any validation.
    You may want to check that the hosts or other fields are not
    "anything".
    """

    # pylint: disable=unreachable
    raise SurpriseError(
        "I haven't tested this version of my script... Oooooh!\n"
        "But I linted it without this exception ;). Aaaaaaaah!\n"
        "XD XD XD\n"
        "Untested Scream Horror Show (Soon on BrainfuckedFlix)",
    )
    # """
    # I haven't tested any version with an empty to_new_folder...

    if verbose:
        print("Connecting to from account.")
    from_account = imaplib.IMAP4_SSL(host=from_host, port=from_port)
    from_account.login(from_login, from_password)

    if verbose:
        print('Connecting to "to account".')
    to_account = imaplib.IMAP4_SSL(host=to_host, port=to_port)
    to_account.login(to_login, to_password)

    if to_new_folder != "":
        if verbose:
            print("Creating new folder in to account.")
        to_account.create(to_new_folder)

    if verbose:
        print("Fetching all emails ids in from account.")
    from_account.select()
    result, ids = from_account.uid("search", "all")
    if verbose:
        print(f'from_account.uid("search") result:{result} ids:{ids}')
    ids = ids[0].decode().split()
    if verbose:
        print("Fetching and transfering each email in from account.")
    for my_id in ids:
        result, raw_message = from_account.uid(
            "fetch",
            my_id,
            "(RFC822)",
        )
        if verbose:
            print(f'from_account.uid("fetch", {my_id}) result:{result}')
        message = raw_message[0][1]
        my_email = email.message_from_string(message.decode("utf-8"))
        flags = imaplib.ParseFlags(raw_message[0][0])
        # flags = " ".join(flags) mypy is unhappy but IMAP flags are
        # ASCII strings, we give mypy what it wants.
        flags_as_strs = [flag.decode("ascii") for flag in flags]
        flags_str = " ".join(flags_as_strs)
        # date = imaplib.Internaldate2tuple(raw_message[0][0])
        date = '"' + my_email["date"] + '"'
        if verbose:
            print(
                f'from_account.uid("fetch", {my_id})'
                f" flags:{flags} date:{date}",
            )
        to_account.append(to_new_folder, flags_str, date, message)


def main() -> None:
    """
    Parse command-line arguments and
    transfert all emails from some IMAP account
    to another IMAP account.
    """
    parser = argparse.ArgumentParser(
        description=(
            "Transfert all emails from some IMAP account"
            " to another IMAP account"
        ),
    )
    parser.add_argument(
        "from_login",
        type=str,
        help="Email account login of user one.",
    )
    parser.add_argument(
        "from_password",
        type=str,
        help="Email account password of user one.",
    )
    parser.add_argument(
        "to_login",
        type=str,
        help="Email account login of user two.",
    )
    parser.add_argument(
        "to_password",
        type=str,
        help="Email account password of user two.",
    )
    parser.add_argument(
        "--to_new_folder",
        type=str,
        default="",
        help="Transfert emails into a new folder of this name.",
    )
    parser.add_argument(
        "--from_host",
        type=str,
        default="imap.gmail.com",
        help="Host of first email account",
    )
    parser.add_argument(
        "--from_port",
        type=int,
        default=993,
        help="Port on host of first email account",
    )
    parser.add_argument(
        "--to_host",
        type=str,
        default="imap.gmail.com",
        help="Host of second email account",
    )
    parser.add_argument(
        "--to_port",
        type=int,
        default=993,
        help="Port on host of second email account",
    )
    parser.add_argument(
        "-v",
        "--verbose",
        action="store_true",
        help="Print details of operations",
    )

    args = parser.parse_args()

    if args.verbose:
        print(
            "-----------------------------------------------------\n"
            "IMAP transfert:\n"
            "-----------------------------------------------------\n"
            "From account:\n"
            f" - Login: {args.from_login}\n"
            f" - Password: {args.from_password}\n"
            f" - Host: {args.from_host}\n"
            f" - Port: {args.from_port}\n"
            "To account:\n"
            f" - Login: {args.to_login}\n"
            f" - Password: {args.to_password}\n"
            f" - Host: {args.to_host}\n"
            f" - Port: {args.to_port}\n"
            "-----------------------------------------------------\n",
        )
        if args.to_new_folder is not None:
            print(
                f"Emails will go in folder {args.to_new_folder}"
                " after it is created.",
            )
    try:
        IMAP_transfert(
            args.from_login,
            args.from_password,
            args.from_host,
            args.from_port,
            args.to_login,
            args.to_password,
            args.to_host,
            args.to_port,
            to_new_folder=args.to_new_folder,
            verbose=args.verbose,
        )
    except (IMAPTransfertBadArgumentError, SurpriseError) as e:
        print(e)


if __name__ == "__main__":
    main()
